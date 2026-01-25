#!/bin/zsh

if [ ! -d "$HOME/.config/nvim" ]; then
  dotlog "install" "Installing nvim"
  mkdir -p $HOME/.config

  # Get the directory of the script
  script_dir=$(dirname "$(realpath "$0")")

  # Create or overwrite the symbolic link
  ln -s "$script_dir" "$HOME/.config/nvim"

  dotlog "info" "Be sure to install neovim for your platform"
else
  dotlog "skip" "Skipping nvim"
fi