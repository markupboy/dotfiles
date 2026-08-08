if status is-interactive; and type -q fzf
    # Leave ctrl-r to atuin
    set -g FZF_CTRL_R_COMMAND ""

    fzf --fish | source
end
