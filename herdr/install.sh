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

# $1 matches against `plugin list`, which names a plugin by its own id, not its repo.
install_plugin () {
  local match=$1 repo=$2 name="${2##*/}"

  if herdr plugin list 2>/dev/null | grep -q "$match"; then
    dotlog "skip" "Skipping $name"
  else
    dotlog "install" "Installing $name"
    herdr plugin install "$repo"
  fi
}

install_plugin worktrunk devashish2203/herdr-worktrunk
install_plugin reviewr   persiyanov/herdr-reviewr
