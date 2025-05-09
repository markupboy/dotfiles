#!/bin/bash

mkdir -p $HOME/.config

# Get the directory of the script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create or overwrite the symbolic link
ln -sf "$script_dir" "$HOME/.config/ghostty"