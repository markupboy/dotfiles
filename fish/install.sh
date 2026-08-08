#!/usr/bin/env bash
#
# Vendor the bobthefish prompt theme.

set -e

BOBTHEFISH="$HOME/.local/share/theme-bobthefish"

if [ ! -d "$BOBTHEFISH" ]; then
  dotlog "install" "Cloning bobthefish"
  git clone --depth 1 https://github.com/oh-my-fish/theme-bobthefish "$BOBTHEFISH"
else
  dotlog "skip" "Skipping bobthefish"
fi
