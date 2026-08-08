function getpath --description 'copy the current path to the clipboard'
    echo -n $PWD | pbcopy
    echo "current path copied to clipboard"
end
