#!/bin/bash

mkdir -p $HOME/.config

# Get the directory of the script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create or overwrite the symbolic link
ln -sf "$script_dir" "$HOME/.config/nvim"

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim