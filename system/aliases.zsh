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

#commands
alias s='screen -U'
alias h='history'
alias mm='mate .'
alias o='open'
alias oo="open ."
alias rm='rm -i'
alias ls='ls -G'
alias ll='ls -lahG'
alias ip='getIP'
alias c='clear'
alias getpath='pwd|tr -d "\r\n"|pbcopy|echo "current path copied to clipboard"'
alias ping='ping -oq'
alias top='top -o cpu'

#nocorrect when you might get a new dir or file
alias vim='nocorrect vim'
alias mate='nocorrect mate'
alias m='nocorrect mate'
alias touch='nocorrect touch'
alias mv='nocorrect mv -i'    
alias cp='nocorrect cp'       
alias mkdir='nocorrect mkdir'