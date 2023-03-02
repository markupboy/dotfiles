# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# spaceship theme and settings (https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md)
ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git
  node
  golang
  docker
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_CHAR_SYMBOL="›"
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_GIT_STATUS_ADDED="%F{yellow}+%F{red}"
SPACESHIP_GIT_STATUS_UNTRACKED="%F{blue}?%F{red}"
SPACESHIP_GIT_STATUS_DELETED="%F{green}x%F{red}"
SPACESHIP_GIT_STATUS_MODIFIED="%F{red}!%F{red}"

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
