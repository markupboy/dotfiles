#!/bin/zsh
set -e

if command -v atuin >/dev/null 2>&1;
then 
  dotlog "skip" "Atuin already installed"
else
  dotlog "install" "Installing Atuin"
  /bin/bash -c "$(curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh)"
fi