wtpr() {
  wt switch "pr:$1" -x claude -- '/pr-review'
}

alias wtc='wt switch --create --execute=ai'

