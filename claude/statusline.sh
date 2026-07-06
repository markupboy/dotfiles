#!/bin/bash
#
# Claude Code statusline: [Model] repo/branch git-branch ██████░░░░ 62% $1.23
# Receives session JSON on stdin.

input=$(cat)

model=$(jq -r '.model.display_name // "?"' <<<"$input")
dir=$(jq -r '.workspace.current_dir // .cwd // ""' <<<"$input")
pct=$(jq -r '.context_window.used_percentage // 0' <<<"$input" | cut -d. -f1)
cost=$(jq -r '.cost.total_cost_usd // 0' <<<"$input")

# worktrunk layout: ~/Code/worktrees/{repo}/{branch} -> "repo/branch"
case "$dir" in
  */worktrees/*) label="${dir#*/worktrees/}" ;;
  *)             label="${dir##*/}" ;;
esac
branch=$(git -C "$dir" branch --show-current 2>/dev/null)
# a worktree label already ends in the branch name; don't repeat it
[[ "$label" == */"$branch" ]] && branch=""

CYAN=$'\033[36m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; RED=$'\033[31m'; RESET=$'\033[0m'
if   [ "$pct" -ge 90 ]; then c=$RED
elif [ "$pct" -ge 70 ]; then c=$YELLOW
else                         c=$GREEN; fi

filled=$((pct / 10)); empty=$((10 - filled))
printf -v fill "%${filled}s"; printf -v pad "%${empty}s"
bar="${fill// /█}${pad// /░}"

cost_fmt=$(printf '$%.2f' "$cost")
printf '%s\n' "${CYAN}[$model]${RESET} $label${branch:+ ${GREEN}$branch${RESET}} ${c}${bar}${RESET} ${pct}% ${YELLOW}${cost_fmt}${RESET}"
