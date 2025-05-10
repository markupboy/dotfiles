#!/bin/zsh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

source $DOTFILES/util/log.zsh

# Check for Homebrew
if test ! $(which brew)
then
  dotlog "install" "Installing Homebrew for you"

  # Install the correct homebrew for Mac or Linux
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  dotlog "info" "Eval'ing brew shellenv"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  
else
  dotlog "skip" "Homebrew already installed"
fi

exit 0