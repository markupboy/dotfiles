#!/bin/zsh

ohmyzsh="$HOME/.oh-my-zsh"
spaceship_prompt="$ohmyzsh/custom/themes/spaceship-prompt"

echo "••• Installing oh-my-zsh"

# install or update shell
shell () {
  if [ -d "$ohmyzsh" -o -L "$ohmyzsh" ]
  then
    echo "•••> updating oh-my-zsh"
    cd "$ohmyzsh" && git pull origin master
  else  
    echo "•••> install oh-my-zsh"
    ZSH= sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended --keep-zshrc"
  fi
}

# install or update spaceship prompt
prompt () {
  if [ -d "$spaceship_prompt/" -o -L "$spaceship_prompt" ]
  then
    echo "•••> updating spaceship prompt"
    cd $spaceship_prompt && git pull origin master
  else
    echo "•••> installing spaceship prompt"
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
      echo "•••> updating $plugin"
      cd "$ohmyzsh/custom/plugins/$plugin" && git pull origin master
    else  
      echo "•••> install $plugin plugin"
      git clone https://github.com/zsh-users/$plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$plugin
    fi
  done
}

shell
prompt
plugins