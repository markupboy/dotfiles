#mysql
alias mysqlstart='launchctl load -w /usr/local/Cellar/mysql/5.1.49/com.mysql.mysqld.plist'
alias mysqlstop='launchctl unload -w /usr/local/Cellar/mysql/5.1.49/com.mysql.mysqld.plist'
alias mampmysql='/Applications/MAMP/Library/bin/mysql'
alias mampmysqldump='/Applications/MAMP/Library/bin/mysqldump'

#postgresql
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'