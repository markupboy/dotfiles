#!/bin/zsh

if [[ "$(uname)" == "Darwin" ]]; then
  dotlog "info" "Running MacOS software update"
  sudo softwareupdate -i -a
fi