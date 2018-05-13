# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# ZSH_THEME="markupboy"
# ZSH_THEME="agnoster"

# spaceship theme and settings (https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md)
ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ORDER=(
  time          # Time stampts section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  docker        # Docker section
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_DIR_TRUNC_REPO=false



# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew bundler gem github osx rake zsh-syntax-highlighting docker docker-compose node npm zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold'
