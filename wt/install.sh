#!/bin/zsh
set -e

if [ ! -d "$HOME/.config/worktrunk" ]; then
  dotlog "install" "Installing worktrunk"
  mkdir -p "$HOME/.config"

  # Get the directory of the script
  script_dir=$(dirname "$(realpath "$0")")

  # Create or overwrite the symbolic link
  ln -s "$script_dir" "$HOME/.config/worktrunk"

  dotlog "info" "Be sure to install worktrunk for your platform"
else
  dotlog "skip" "Skipping worktrunk"
fi
