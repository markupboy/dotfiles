#!/bin/zsh
set -e

if [[ "$(uname)" == "Darwin" ]]; then
  dotlog "info" "Running MacOS software update"
  sudo softwareupdate -i -a
else
  dotlog "skip" "Skipping - not a mac"
fi