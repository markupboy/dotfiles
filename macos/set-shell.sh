#!/bin/sh
#
# Make fish the login shell, if it's available.
say() {
  if command -v dotlog >/dev/null 2>&1; then
    dotlog "$1" "$2"
  else
    echo "  $2"
  fi
}

fish_bin=$(command -v fish 2>/dev/null)

if [ -z "$fish_bin" ]; then
  say skip "fish not installed yet — it comes from the Brewfile"
  exit 0
fi

# Read the login shell from the user record
current=$(dscl . -read "/Users/$USER" UserShell 2>/dev/null | awk '{print $2}')

if [ "$current" = "$fish_bin" ]; then
  say skip "login shell is already $fish_bin"
  exit 0
fi

# chsh refuses any shell that isn't listed in /etc/shells
if ! grep -qxF "$fish_bin" /etc/shells; then
  say user "Adding $fish_bin to /etc/shells (requires sudo)"
  echo "$fish_bin" | sudo tee -a /etc/shells >/dev/null
fi

say user "Changing login shell from $current to $fish_bin"
chsh -s "$fish_bin"
say info "Open a new terminal for the change to take effect"
