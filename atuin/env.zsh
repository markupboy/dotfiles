if [[ -a ~/.atuin/bin/env ]]; then
  . "$HOME/.atuin/bin/env"
  eval "$(atuin init zsh --disable-up-arrow)"
fi

export ATUIN_CONFIG_DIR=$DOTFILES/atuin