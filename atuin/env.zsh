if [[ -a ~/.atuin/bin/env ]]; then
  . "$HOME/.atuin/bin/env"
  eval "$(atuin init zsh)"
fi

export ATUIN_CONFIG_DIR=$DOTFILES/atuin