#!/bin/zsh
set -e

if [ ! -d "$HOME/.tmux/plugins" ]; then
  dotlog "install" "Setting up tmux"
  
  mkdir -p $HOME/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  dotlog "skip" "Skipping tmux"
fi