if [[ "$AI_CLI" == "cursor" ]]; then
  ai_cli="cursor-agent --force"
else
  ai_cli="claude --dangerously-skip-permissions"
fi

alias ai="${ai_cli}"
alias aic="${ai_cli} --continue"
alias air="${ai_cli} --resume"

