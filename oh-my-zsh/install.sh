#!/bin/zsh
parentDirectory=$(dirname "$(realpath "$0")")
dotfilesDirectory=$(dirname "$parentDirectory")

source $dotfilesDirectory/util/log.zsh

ohmyzsh="$HOME/.oh-my-zsh"
spaceship_prompt="$ohmyzsh/custom/themes/spaceship-prompt"

install "Installing oh-my-zsh"

# install or update shell
shell () {
  if [ -d "$ohmyzsh" -o -L "$ohmyzsh" ]
  then
    log "updating oh-my-zsh"
    cd "$ohmyzsh" && git pull origin master
  else  
    install "install oh-my-zsh"
    ZSH= sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended --keep-zshrc"
  fi
}

# install or update spaceship prompt
prompt () {
  if [ -d "$spaceship_prompt/" -o -L "$spaceship_prompt" ]
  then
    log "updating spaceship prompt"
    cd $spaceship_prompt && git pull origin master
  else
    install "installing spaceship prompt"
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$spaceship_prompt" --depth=1
    ln -s "$spaceship_prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
  fi
}

plugins () {
  p=(zsh-syntax-highlighting zsh-autosuggestions)
  for plugin in "${p[@]}"
  do
    if [ -d "$ohmyzsh/custom/plugins/$plugin" -o -L "$ohmyzsh/custom/plugins/$plugin" ]
    then
      log "updating $plugin"
      cd "$ohmyzsh/custom/plugins/$plugin" && git pull origin master
    else  
      install "install $plugin plugin"
      git clone https://github.com/zsh-users/$plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin
    fi
  done
}

shell
prompt
plugins