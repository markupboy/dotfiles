#commands
alias h='history'
alias o='open'
alias oo="open ."
alias rm='rm -i'
alias ip='getIP'
alias c='clear'
alias getpath='echo -n $PWD|pbcopy|echo "current path copied to clipboard"'
alias ping='ping -oq'
alias top='top -o cpu'
alias getip="getIP"
alias ack='ACK_PAGER_COLOR="less -x4SRFX" ack -a'
alias st="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ."
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias mmserver="bundle exec middleman server --host=0.0.0.0"

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
alias vim='nocorrect vim'
alias touch='nocorrect touch'
alias mv='nocorrect mv -i'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

# make executable
alias ax="chmod a+x"

# google chrome
alias chrome="open -a \"Google Chrome\""

#copy output of last command to clipboard
alias cl="fc -e -|pbcopy"
alias copylast="fc -e -|pbcopy"

# top
alias cpu='top -o cpu'
alias mem='top -o rsize'

# Pipe my public key to my clipboard
alias getkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
