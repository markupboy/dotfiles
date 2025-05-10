#!/bin/zsh
parentDirectory=$(dirname "$(realpath "$0")")
dotfilesDirectory=$(dirname "$parentDirectory")

source $dotfilesDirectory/util/log.zsh

if [[ "$(uname)" == "Darwin" ]]; then
  log "Running MacOS software update"
  sudo softwareupdate -i -a
fi