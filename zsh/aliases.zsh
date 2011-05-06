###########
# aliases #
###########

#commands
alias s='screen -U'
alias h='history'
alias o='open'
alias rm='rm -i'
alias ls='ls -G'
alias ll='ls -lahG'
alias extract='smartextract'
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

#mercurial
alias hg='/usr/local/Cellar/python/2.6.5/bin/hg'

#directories
alias clients='cd ~/Sites/viget/clients'