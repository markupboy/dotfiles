if [[ $(uname) == "Darwin" ]]; then
    alias o='open'
    alias oo="open ."
    alias getpath='echo -n $PWD|pbcopy|echo "current path copied to clipboard"'

    # chrome cli
    alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
fi
