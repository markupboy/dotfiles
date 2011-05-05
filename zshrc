######################################################
# lots of stuff borrowed from Zach Holman here:      #
# https://github.com/holman/dotfiles/blob/master/zsh #
######################################################

# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/Dropbox/Shared\ Libraries/dotfiles

# source every .zsh file in this rep
for config_file ($ZSH/**/*.zsh) source $config_file

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

##############
# completion #
##############

# initialize autocomplete here, otherwise functions won't be loaded

zmodload zsh/complist
autoload -Uz compinit && compinit