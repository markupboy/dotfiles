#!/bin/zsh

if [ ! -d "$HOME/.config/ghostty" ]; then
  dotlog "install" "Installing ghostty"
  mkdir -p $HOME/.config

  # Get the directory of the script
  script_dir=$(dirname "$(realpath "$0")")

  # Create or overwrite the symbolic link
  ln -s "$script_dir" "$HOME/.config/ghostty"

  dotlog "info" "Be sure to install ghostty for your platform"
else
  dotlog "skip" "Skipping ghostty"
fi