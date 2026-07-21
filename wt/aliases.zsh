wtpr() {
  local pr="$1"
  if [[ -z "$pr" ]]; then
    echo "usage: wtpr <pr-number>" >&2
    return 1
  fi

  # Create/resolve the PR worktree and grab its path. --no-cd because tmux
  # (not this shell) handles navigation. NB: don't name this `path` — in zsh
  # that's the array tied to $PATH, and `local path` would blank $PATH for the
  # whole function. `wt switch` emits the path under .path.
  local wt_path
  wt_path=$(wt switch "pr:$pr" --no-cd --format json | jq -r '.path') || return
  if [[ -z "$wt_path" || "$wt_path" == "null" ]]; then
    echo "wtpr: could not resolve worktree path for pr:$pr" >&2
    return 1
  fi

  local session="pr-$pr"
  if ! tmux has-session -t "=$session" 2>/dev/null; then
    tmux new-session -d -s "$session" -c "$wt_path"     # pane 0 (left)
    tmux split-window -h -t "$session:" -c "$wt_path"   # pane 1 (right, plain shell)
    tmux select-pane -t "$session:.0"
    tmux send-keys -t "$session:.0" 'ai /pr-review' Enter
  fi

  # Name the Ghostty window "repo - #PR". --git-common-dir resolves to the main
  # repo's .git even from a linked worktree, so its parent is the repo name.
  # tmux.conf reads @ghostty_title into set-titles-string.
  # NB: no "=" prefix on the target — tmux set-option rejects "=name" with
  # "no such session" (unlike has-session), so use the plain session name.
  local repo
  repo=$(basename "$(dirname "$(git -C "$wt_path" rev-parse --path-format=absolute --git-common-dir 2>/dev/null)")")
  tmux set-option -t "$session" @ghostty_title "$repo - #$pr"

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session"
  else
    tmux attach-session -t "$session"
    # If the session is gone once attach returns, it was killed (e.g. by wtprx)
    # rather than detached, so exit this shell and let Ghostty close the window.
    # A manual detach (prefix-d) leaves the session alive, so we fall through to
    # the prompt instead.
    tmux has-session -t "=$session" 2>/dev/null || exit
  fi
}

# Companion to wtpr: kill a PR's tmux session and close its terminal window.
# Run it from inside the pr-<n> session, or pass the PR number explicitly.
# Killing the session detaches the attached client; wtpr's attach branch then
# sees the session is gone and exits the shell, which closes the Ghostty window.
wtprx() {
  local session
  if [[ -n "$1" ]]; then
    session="pr-$1"
  elif [[ -n "$TMUX" ]]; then
    session=$(tmux display-message -p '#S')
  else
    echo "usage: wtprx <pr-number>  (or run inside the pr-<n> tmux session)" >&2
    return 1
  fi

  if ! tmux has-session -t "=$session" 2>/dev/null; then
    echo "wtprx: no tmux session '$session'" >&2
    return 1
  fi

  tmux kill-session -t "=$session"
}

alias wtc='wt switch --create --execute=ai'
alias wtl='wt list'

# remove worktrees whose branches are merged into main
wtclean() {
  local b
  wt list --format json \
    | jq -r '.[] | select((.is_main or .is_current) | not) | select(.main_state == "integrated" or .main_state == "empty") | .branch' \
    | while read -r b; do
        wt remove --foreground "$b"
      done
}

