#commands
alias s='screen -U'
alias h='history'
alias o='open'
alias oo="open ."
alias rm='rm -i'
# alias ls='ls -G'
# alias ll='ls -lahG'
alias ip='getIP'
alias c='clear'
alias getpath='echo -n $PWD|pbcopy|echo "current path copied to clipboard"'
alias ping='ping -oq'
alias top='top -o cpu'
alias getip="getIP"
alias ack='ACK_PAGER_COLOR="less -x4SRFX" ack -a'
alias st="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ."
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

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
alias mate='nocorrect mate'
alias m='nocorrect mate'
alias touch='nocorrect touch'
alias mv='nocorrect mv -i'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the Open With submenu.
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

# make executable
alias ax="chmod a+x"

# google chrome
alias chrome="open -a \"Google Chrome Canary\""

#copy output of last command to clipboard
alias cl="fc -e -|pbcopy"
alias copylast="fc -e -|pbcopy"

# top
alias cpu='top -o cpu'
alias mem='top -o rsize' # memory
# alias htop='htop −−sort−key cpu'

# recursively delete Dropbox conflicted files
alias rmdbc="find . -name *\ \(*conflicted* -exec rm {} \;"

# mute the system volume
alias stfu="osascript -e 'set volume output muted true'"

