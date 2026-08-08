if [[ $(uname) == "Darwin" ]]; then
    alias o='open'
    alias oo="open ."
    alias getpath='echo -n $PWD|pbcopy|echo "current path copied to clipboard"'
fi
