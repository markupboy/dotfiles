###############
# environment #
###############

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
	export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/git/libexec/git-core:$PATH" 
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export EDITOR='mate -w'