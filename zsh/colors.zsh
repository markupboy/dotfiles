# Cache vivid output for performance
if [[ ! -f ~/.cache/ls_colors ]] || [[ ~/.dotfiles/zsh/colors.zsh -nt ~/.cache/ls_colors ]]; then
  mkdir -p ~/.cache
  vivid generate one-dark > ~/.cache/ls_colors
fi
export LS_COLORS="$(cat ~/.cache/ls_colors)"