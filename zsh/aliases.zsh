###########
# aliases #
###########

#commands
alias ack='ack'
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

#mysql
alias mysqlstart='launchctl load -w /usr/local/Cellar/mysql/5.1.49/com.mysql.mysqld.plist'
alias mysqlstop='launchctl unload -w /usr/local/Cellar/mysql/5.1.49/com.mysql.mysqld.plist'
alias mampmysql='/Applications/MAMP/Library/bin/mysql'
alias mampmysqldump='/Applications/MAMP/Library/bin/mysqldump'

#postgresql
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

#django
alias runserver='python manage.py runserver'
alias syncdb='pyhton manage.py syncdb'
alias migrate='python manage.py migrate'
alias schemamigration='python manage.py schemamigration'

#mercurial
alias hg='/usr/local/Cellar/python/2.6.5/bin/hg'

#directories
alias clients='cd ~/Sites/viget/clients'