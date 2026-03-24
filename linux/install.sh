#!/bin/sh
#
# Install Linuxbrew build dependencies on Debian/Ubuntu

if [ "$(uname)" = "Darwin" ]; then
  exit 0
fi

if command -v apt-get >/dev/null 2>&1; then
  echo "  Installing Linuxbrew build dependencies..."
  sudo apt-get update
  sudo apt-get install -y build-essential procps curl file git
fi
