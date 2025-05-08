#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."

  # Install the correct homebrew for Mac or Linux
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  echo "Eval'ing brew shellenv."
  eval "$(/opt/homebrew/bin/brew shellenv)"
  
else
  echo "  Homebrew already installed"
fi

if [ ! -f $HOME/Brewfile ]; then
  echo "  Linking Brewfile."
  ln -s Brewfile $HOME/Brewfile 
else
  echo "  Brewfile already exists."
fi

exit 0