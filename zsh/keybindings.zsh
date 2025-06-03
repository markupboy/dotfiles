# keybindings
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space			# also do history expansion on space
bindkey '^I' complete-word	# complete on tab, leave expansion to _expand

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
