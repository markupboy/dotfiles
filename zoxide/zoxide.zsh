if command -v zoxide &>/dev/null; then
  if [[ -z "${CLAUDECODE}" ]]; then
    eval "$(zoxide init zsh)"
    alias cd='z'
  fi
fi
