#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "$0")" && pwd -P)"

# 1. Link this directory to ~/.config/fish
if [ -e "$HOME/.config/fish/config.fish" ]; then
  dotlog "skip" "Skipping fish config"
elif [ -e "$HOME/.config/fish" ] && [ ! -L "$HOME/.config/fish" ]; then
  # A real directory with someone else's config in it — don't touch it.
  dotlog "error" "$HOME/.config/fish exists and is not a symlink; move it aside and re-run"
  exit 1
else
  dotlog "install" "Installing fish config"
  mkdir -p "$HOME/.config"
  # Clear any stale (possibly dangling) symlink first, so ln doesn't create the
  # new link *inside* the old target.
  [ -L "$HOME/.config/fish" ] && rm -f "$HOME/.config/fish"
  ln -sfn "$script_dir" "$HOME/.config/fish"
fi

# 2. Make fish the login shell.
#    On macOS that's macos/set-shell.sh, which `dot` runs alongside the other
#    system defaults — nothing to do here.
if [ "$(uname)" = "Darwin" ]; then
  exit 0
fi

FISH_BIN="$(command -v fish 2>/dev/null || true)"
if [ -z "$FISH_BIN" ]; then
  dotlog "info" "fish is not installed yet — it comes from the Brewfile. Re-run this installer afterwards to set it as your login shell."
  exit 0
fi

# Read the login shell from the passwd record rather than $SHELL, which is
# inherited from whatever launched this process and goes stale after chsh.
CURRENT_SHELL="$(getent passwd "$USER" 2>/dev/null | cut -d: -f7)"
if [ "$CURRENT_SHELL" = "$FISH_BIN" ]; then
  dotlog "skip" "fish is already the login shell"
  exit 0
fi

# chsh refuses any shell that isn't listed in /etc/shells
if ! grep -qxF "$FISH_BIN" /etc/shells; then
  dotlog "user" "Adding $FISH_BIN to /etc/shells (requires sudo)"
  echo "$FISH_BIN" | sudo tee -a /etc/shells >/dev/null
fi

dotlog "user" "Changing login shell from $CURRENT_SHELL to $FISH_BIN"
chsh -s "$FISH_BIN"
dotlog "info" "Open a new terminal for the change to take effect"
