if status is-interactive
    alias rm 'rm -i'
    alias mv 'mv -i'
    alias c clear
    alias top 'top -o cpu'
    alias getip getIP
    alias whatismyip getIP
    alias vim nvim

    # eza overrides for ls
    if type -q eza
        alias ls "eza --icons --group-directories-first -lAh"
        alias l "eza --icons --group-directories-first -lAh"
        alias ll "eza --icons --group-directories-first -lAh"
        alias la "eza --icons --group-directories-first -A"
    end

    # ripgrep aliases
    if type -q rg
        alias search rg
        alias ag rg
    end

    # bat overrides for cat
    if type -q bat
        alias cat "bat --paging=never"
    end

    # ide alias; type -q so a missing cursor doesn't shadow a working code
    if test "$DEV_TOOLS" = cursor; and type -q cursor
        alias code "cursor --classic"
    end
    alias ccc 'code .'
end
