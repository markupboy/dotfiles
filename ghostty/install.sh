#!/bin/sh

GHOSTTY_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p $HOME/.config
ln -s $GHOSTTY_CONFIG_DIR $HOME/.config/ghostty