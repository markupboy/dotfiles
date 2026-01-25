#!/bin/zsh

if [[ $LINUX ]]; then
  if [ ! -f "/usr/local/bin/starship" ]; then
    dotlog "install" "Installing starship prompt"
    curl -sS https://starship.rs/install.sh | sh
  else
    dotlog "skip" "Skipping starship prompt"
  fi
  dotlog "skip" "Skipping starship prompt"
fi