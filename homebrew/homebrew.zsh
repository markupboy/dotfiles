if [[ -d /opt/homebrew ]]; then
  # macOS ARM
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d /home/linuxbrew/.linuxbrew ]]; then
  # Linux (default Linuxbrew location)
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -d "$HOME/.linuxbrew" ]]; then
  # Linux (user-local Linuxbrew)
  eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
fi