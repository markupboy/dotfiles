#!/bin/zsh
set -e

BREW_BIN="$(command -v brew || echo /opt/homebrew/bin/brew)"

if ! [[ $WIN || $LINUX ]]; 
then

  # Check for Homebrew
  if [ -f "$BREW_BIN" ]; then
    dotlog "skip" "Homebrew already installed"
  else
    dotlog "install" "Installing Homebrew for you"

    # Install the correct homebrew for Mac or Linux
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    dotlog "info" "Eval'ing brew shellenv"
    eval "$($BREW_BIN shellenv)"
  fi
else
  dotlog "skip" "Skipping homebrew"
fi