#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "$0")" && pwd -P)"

if [ -e "$HOME/.config/fish/config.fish" ]; then
  dotlog "skip" "Skipping fish config"

elif [ -e "$HOME/.config/fish" ] && [ ! -L "$HOME/.config/fish" ]; then
  dotlog "error" "$HOME/.config/fish exists and is not a symlink; move it aside and re-run"

  exit 1

else
  dotlog "install" "Installing fish config"

  mkdir -p "$HOME/.config"

  [ -L "$HOME/.config/fish" ] && rm -f "$HOME/.config/fish"

  ln -sfn "$script_dir" "$HOME/.config/fish"
fi

