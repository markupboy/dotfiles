#!/bin/zsh
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

mkdir -p ~/.vim/colors
curl -s -o ~/.vim/colors/onedark.vim https://raw.githubusercontent.com/joshdick/onedark.vim/refs/heads/main/colors/onedark.vim

mkdir -p ~/.vim/autoload
curl -s -o ~/.vim/autoload/onedark.vim https://raw.githubusercontent.com/joshdick/onedark.vim/refs/heads/main/autoload/onedark.vim

mkdir -p ~/.vim/autoload/airline/themes
curl -s -o ~/.vim/autoload/airline/themes/onedark.vim https://raw.githubusercontent.com/joshdick/onedark.vim/refs/heads/main/autoload/airline/themes/onedark.vim

vim +PluginInstall +qall