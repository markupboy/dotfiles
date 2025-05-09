#!/bin/bash

if [ ! -d "$HOME/.config/nvim" ]; then
  mkdir -p $HOME/.config

  # Get the directory of the script
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  # Create or overwrite the symbolic link
  ln -s "$script_dir" "$HOME/.config/nvim"
fi