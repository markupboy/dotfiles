alias ai="claude --dangerously-skip-permissions"
alias aic="claude --dangerously-skip-permissions --continue"
alias air="claude --dangerously-skip-permissions --resume"

# headless one-shot: aip "prompt" [extra claude flags]
aip() {
  claude -p "$@"
}
