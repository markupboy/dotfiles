function wtprx --description "kill a PR's tmux session and close its terminal window"
    set -l session
    if test -n "$argv[1]"
        set session "pr-$argv[1]"
    else if set -q TMUX
        set session (tmux display-message -p '#S')
    else
        echo "usage: wtprx <pr-number>  (or run inside the pr-<n> tmux session)" >&2
        return 1
    end

    if not tmux has-session -t "=$session" 2>/dev/null
        echo "wtprx: no tmux session '$session'" >&2
        return 1
    end

    tmux kill-session -t "=$session"
end
