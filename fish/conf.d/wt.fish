if type -q wt
    command wt config shell init fish | source
end

if status is-interactive
    alias wtc 'wt switch --create --execute=ai'
    alias wtl 'wt list'
    # wtpr / wtprx / wtclean live in fish/functions/
end
