#commands
alias rm='rm -i'
alias c='clear'
alias top='top -o cpu'
alias getip="getIP"
alias whatismyip="getip"

# eza overides for ls
if command -v eza &>/dev/null
then
  alias ls="eza --icons --group-directories-first"
  alias l="eza --icons --group-directories-first -lAh"
  alias ll="eza --icons --group-directories-first -l"
  alias la='eza --icons --group-directories-first -A'
fi

# ripgrep overrides for grep and ag
if command -v rg &>/dev/null
then
  alias grep="rg"
  alias ag="rg"
fi

# bat overrides for cat
if command -v bat &>/dev/null
then
  alias cat="bat"
fi


#nocorrect when you might get a new dir or file
alias vim='nocorrect nvim'
alias touch='nocorrect touch'
alias mv='nocorrect mv -i'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

# Pipe my public key to my clipboard
alias getkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

