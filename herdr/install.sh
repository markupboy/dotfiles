#!/usr/bin/env bash
#
# Install the herdr plugins: worktrunk backs the wtc/wtpr workspace layout,
# reviewr the PR review flow.

set -e

# herdr comes from the Brewfile, so on a fresh machine dot runs before it exists.
if ! command -v herdr >/dev/null; then
  dotlog "skip" "Skipping herdr plugins (herdr not installed yet)"
  exit 0
fi

# `plugin list` names a plugin by its own id, not its repo, and exits 0 either
# way — so ask for the one id and look for it in the response.
plugin_installed () {
  herdr plugin list --plugin "$1" --json 2>/dev/null | grep -q "\"plugin_id\":\"$1\""
}

install_plugin () {
  local id=$1 repo=$2 name="${2##*/}"

  if plugin_installed "$id"; then
    dotlog "skip" "$name already installed"
  else
    dotlog "install" "Installing $name"
    # --yes must follow the repo; herdr rejects it before the positional, --help notwithstanding.
    herdr plugin install "$repo" --yes
  fi
}

install_plugin worktrunk          devashish2203/herdr-worktrunk
install_plugin persiyanov.reviewr persiyanov/herdr-reviewr
