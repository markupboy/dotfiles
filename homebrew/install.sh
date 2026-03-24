#!/bin/zsh
set -e

BREW_BIN="$(command -v brew || true)"

# Determine default brew path per platform
if [[ -z "$BREW_BIN" ]]; then
  if [[ -f /opt/homebrew/bin/brew ]]; then
    BREW_BIN="/opt/homebrew/bin/brew"
  elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    BREW_BIN="/home/linuxbrew/.linuxbrew/bin/brew"
  elif [[ -f "$HOME/.linuxbrew/bin/brew" ]]; then
    BREW_BIN="$HOME/.linuxbrew/bin/brew"
  fi
fi

# Check for Homebrew
if [[ -n "$BREW_BIN" && -f "$BREW_BIN" ]]; then
  dotlog "skip" "Homebrew already installed"
else
  dotlog "install" "Installing Homebrew for you"

  # Install the correct homebrew for Mac or Linux
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Re-detect brew path after install
  if [[ -f /opt/homebrew/bin/brew ]]; then
    BREW_BIN="/opt/homebrew/bin/brew"
  elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    BREW_BIN="/home/linuxbrew/.linuxbrew/bin/brew"
  elif [[ -f "$HOME/.linuxbrew/bin/brew" ]]; then
    BREW_BIN="$HOME/.linuxbrew/bin/brew"
  fi

  dotlog "info" "Eval'ing brew shellenv"
  eval "$($BREW_BIN shellenv)"
fi