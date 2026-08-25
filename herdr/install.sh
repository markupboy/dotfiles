#!/usr/bin/env bash
#
# Install the worktrunk plugin that backs the wtc/wtpr workspace layout.

set -e

# herdr comes from the Brewfile, so on a fresh machine dot runs before it exists.
if ! command -v herdr >/dev/null; then
  dotlog "skip" "Skipping herdr plugins (herdr not installed yet)"
  exit 0
fi

if herdr plugin list 2>/dev/null | grep -q worktrunk; then
  dotlog "skip" "Skipping herdr-worktrunk"
else
  dotlog "install" "Installing herdr-worktrunk"
  herdr plugin install devashish2203/herdr-worktrunk
fi
