#!/bin/zsh

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

mkdir -p ~/.vim/colors
curl -o ~/.vim/colors/onedark.vim https://raw.githubusercontent.com/joshdick/onedark.vim/refs/heads/main/colors/onedark.vim

mkdir -p ~/.vim/autoload
curl -o ~/.vim/autoload/onedark.vim https://raw.githubusercontent.com/joshdick/onedark.vim/refs/heads/main/autoload/onedark.vim

mkdir -p ~/.vim/autoload/airline/themes
curl -o ~/.vim/autoload/airline/themes/onedark.vim https://raw.githubusercontent.com/joshdick/onedark.vim/refs/heads/main/autoload/airline/themes/onedark.vim