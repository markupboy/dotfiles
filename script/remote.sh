#!/usr/bin/env bash
#
# One-liner dotfiles install:
#   curl -fsSL https://raw.githubusercontent.com/markupboy/dotfiles/main/script/remote-install | bash
#

set -e

DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/markupboy/dotfiles.git"

fmt_info()    { printf '\033[46;30m info \033[0m %s\n' "$1"; }
fmt_error()   { printf '\033[41;30m error \033[0m %s\n' "$1"; }
fmt_success() { printf '\033[42;30m ok \033[0m %s\n' "$1"; }

# Check for git
if ! command -v git >/dev/null 2>&1; then
  fmt_error "git is not installed. Please install git first."
  exit 1
fi

# Clone or update
if [ -d "$DOTFILES_DIR" ]; then
  fmt_info "dotfiles already exist at $DOTFILES_DIR, pulling latest..."
  git -C "$DOTFILES_DIR" pull --rebase
else
  fmt_info "cloning dotfiles into $DOTFILES_DIR..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

fmt_success "dotfiles cloned"

# Run bootstrap
fmt_info "running bootstrap..."
cd "$DOTFILES_DIR"
exec zsh script/bootstrap
