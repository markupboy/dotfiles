if [[ -a ~/.atuin/bin/env ]]; then
  . "$HOME/.atuin/bin/env"
  eval "$(atuin init zsh)"
fi
