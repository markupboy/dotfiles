#!/bin/zsh

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

mkdir -p ~/.vim/colors
wget --output-document ~/.vim/colors/onedark.vim https://raw.githubusercontent.com/joshdick/onedark.vim/refs/heads/main/colors/onedark.vim

mkdir -p ~/.vim/autoload
wget --output-document ~/.vim/autoload/onedark.vim https://raw.githubusercontent.com/joshdick/onedark.vim/refs/heads/main/autoload/onedark.vim

mkdir -p ~/.vim/autoload/airline/themes
wget --output-document ~/.vim/autoload/airline/themes/onedark.vim https://raw.githubusercontent.com/joshdick/onedark.vim/refs/heads/main/autoload/airline/themes/onedark.vim