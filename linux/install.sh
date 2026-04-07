#!/bin/sh
#
# Install Linuxbrew build dependencies on Debian/Ubuntu

if [ "$(uname)" = "Darwin" ]; then
  exit 0
fi

if command -v apt-get >/dev/null 2>&1; then
  missing=""
  for pkg in build-essential procps curl file git; do
    dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "install ok installed" || missing="$missing $pkg"
  done

  if [ -n "$missing" ]; then
    echo "  Installing missing Linuxbrew build dependencies:$missing"
    sudo apt-get update
    sudo apt-get install -y $missing
  else
    echo "  Linuxbrew build dependencies already installed, skipping."
  fi
fi
