wtpr() {
  wt switch "pr:$1" -x ai -- '/pr-review'
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

