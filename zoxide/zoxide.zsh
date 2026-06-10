if command -v zoxide &>/dev/null; then
  if [[ "$CLAUDECODE" != "1" ]]; then
    eval "$(zoxide init zsh)"
  fi
fi
