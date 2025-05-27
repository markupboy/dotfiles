#!/bin/zsh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if command -v brew >/dev/null 2>&1; 
then
  dotlog "skip" "Homebrew already installed"
else
  dotlog "install" "Installing Homebrew for you"

  # Install the correct homebrew for Mac or Linux
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  dotlog "info" "Eval'ing brew shellenv"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

exit 0