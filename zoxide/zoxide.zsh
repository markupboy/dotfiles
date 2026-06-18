if command -v zoxide &>/dev/null; then
  if [[ -z "${CLAUDECODE}" ]]; then
    eval "$(zoxide init zsh)"
  fi
fi
