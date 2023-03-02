# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# spaceship theme and settings (https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md)
export SPACESHIP_CONFIG="$HOME/.spaceshiprc.zsh"
ZSH_THEME="spaceship"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  brew
  github
  macos
  rake
  zsh-syntax-highlighting 
  docker 
  docker-compose
  zsh-autosuggestions
  )

# ignore insecure directories warning
ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold'
