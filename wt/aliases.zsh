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

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session"
  else
    tmux attach-session -t "$session"
  fi
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

