function getpath --description 'copy the current path to the clipboard'
    if type -q pbcopy
        echo -n $PWD | pbcopy
    else if type -q xclip
        echo -n $PWD | xclip -selection clipboard
    else if type -q wl-copy
        echo -n $PWD | wl-copy
    else if set -q WIN
        echo -n $PWD | clip.exe
    else
        echo "getpath: no clipboard command found" >&2
        return 1
    end

    echo "current path copied to clipboard"
end
