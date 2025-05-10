#!/bin/zsh
parentDirectory=$(dirname "$(realpath "$0")")
dotfilesDirectory=$(dirname "$parentDirectory")

source $dotfilesDirectory/util/log.zsh

if [ ! -d "$HOME/.config/nvim" ]; then
  install "Installing nvim"
  mkdir -p $HOME/.config

  # Get the directory of the script
  script_dir=$(dirname "$(realpath "$0")")

  # Create or overwrite the symbolic link
  ln -s "$script_dir" "$HOME/.config/nvim"
else
  skip "Skipping nvim"
fi