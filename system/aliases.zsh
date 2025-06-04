#commands
alias rm='rm -i'
alias ip='getIP'
alias c='clear'
alias top='top -o cpu'
alias getip="getIP"
alias whatismyip="getip"

# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

#nocorrect when you might get a new dir or file
alias vim='nocorrect nvim'
alias touch='nocorrect touch'
alias mv='nocorrect mv -i'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

# Pipe my public key to my clipboard
alias getkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"