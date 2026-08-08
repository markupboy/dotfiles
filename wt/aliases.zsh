# Fast-forward a PR worktree to the PR's current head.
_wtpr_sync() {
  local pr="$1" wt_path="$2"

  git -C "$wt_path" symbolic-ref --quiet HEAD >/dev/null || return 0  # detached

  # -uno so /pr-review's untracked review_*.md files don't block the pull;
  if [[ -n "$(git -C "$wt_path" status --porcelain -uno)" ]]; then
    echo "wtpr: worktree has uncommitted changes — skipping pull" >&2
    return 0
  fi

  if ! git -C "$wt_path" fetch --quiet origin "refs/pull/$pr/head"; then
    echo "wtpr: could not fetch refs/pull/$pr/head — skipping pull" >&2
    return 0
  fi

  local before head
  before=$(git -C "$wt_path" rev-parse HEAD)
  head=$(git -C "$wt_path" rev-parse FETCH_HEAD)
  [[ "$before" == "$head" ]] && return 0

  # Swallow git's "can't be fast-forwarded" advice block
  if git -C "$wt_path" merge --ff-only --quiet FETCH_HEAD 2>/dev/null; then
    echo "wtpr: pulled $(git -C "$wt_path" rev-list --count "$before..HEAD") new commit(s) → $(git -C "$wt_path" rev-parse --short HEAD)"
  else
    echo "wtpr: local branch has diverged from PR #$pr — skipping pull" >&2
  fi
}

# quickly spawn a PR review session from an identifier
wtpr() {
  local pr="$1"
  if [[ -z "$pr" ]]; then
    echo "usage: wtpr <pr-number>" >&2
    return 1
  fi

  # Create/resolve the PR worktree and grab its path
  local wt_path
  wt_path=$(wt switch "pr:$pr" --no-cd --format json | jq -r '.path') || return
  if [[ -z "$wt_path" || "$wt_path" == "null" ]]; then
    echo "wtpr: could not resolve worktree path for pr:$pr" >&2
    return 1
  fi

  _wtpr_sync "$pr" "$wt_path"

  local session="pr-$pr"
  if ! tmux has-session -t "=$session" 2>/dev/null; then
    tmux new-session -d -s "$session" -c "$wt_path"     # pane 0 (top)
    tmux split-window -v -t "$session:" -c "$wt_path"   # pane 1 (bottom, vim)
    tmux send-keys -t "$session:.1" 'vim .' Enter
    tmux select-pane -t "$session:.0"
    tmux send-keys -t "$session:.0" 'ai /pr-review' Enter
  fi

  # Name the Ghostty window "repo - #PR"
  local repo
  repo=$(basename "$(dirname "$(git -C "$wt_path" rev-parse --path-format=absolute --git-common-dir 2>/dev/null)")")
  tmux set-option -t "$session" @ghostty_title "$repo - #$pr"

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session"
  else
    tmux attach-session -t "$session"
    tmux has-session -t "=$session" 2>/dev/null || exit
  fi
}

# kill a PR's tmux session and close its terminal window
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

