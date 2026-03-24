# Cache vivid output for performance
if command -v vivid &>/dev/null; then
  if [[ ! -f ~/.cache/ls_colors ]] || [[ $ZSH/zsh/colors.zsh -nt ~/.cache/ls_colors ]]; then
    mkdir -p ~/.cache
    vivid generate one-dark > ~/.cache/ls_colors
  fi
  export LS_COLORS="$(<~/.cache/ls_colors)"
fi