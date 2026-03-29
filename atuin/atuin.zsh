if [[ -a ~/.atuin/bin/env ]]; then
  . "$HOME/.atuin/bin/env"
fi

if command -v atuin &>/dev/null; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

export ATUIN_CONFIG_DIR=$DOTFILES/atuin