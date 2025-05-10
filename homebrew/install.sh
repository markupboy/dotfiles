#!/bin/zsh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

parentDirectory=$(dirname "$(realpath "$0")")
dotfilesDirectory=$(dirname "$parentDirectory")

source $dotfilesDirectory/util/log.zsh

# Check for Homebrew
if test ! $(which brew)
then
  install "Installing Homebrew for you"

  # Install the correct homebrew for Mac or Linux
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  log "Eval'ing brew shellenv"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  
else
  skip "Homebrew already installed"
fi

if [ ! -f $HOME/Brewfile ]; then
  log "Linking Brewfile"
  SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  ln -s $SCRIPT_DIR/Brewfile $HOME/Brewfile 
else
  skip "Brewfile already exists"
fi

exit 0