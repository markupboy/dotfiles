# Set up the Starship prompt
export STARSHIP_CONFIG=$DOTFILES/starship/starship.toml

if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi