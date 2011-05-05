# enable and configure the history
setopt APPEND_HISTORY			# append the history file (!important for using multiple zsh sessions)
setopt SHARE_HISTORY			# use commands history files used by different zsh sessions
setopt HIST_IGNORE_DUPS		# ignore adjacent duplicate commands

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
DIRSTACKSIZE=20