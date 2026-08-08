function wtpr --description 'quickly spawn a PR review session from an identifier'
    set -l pr $argv[1]
    if test -z "$pr"
        echo "usage: wtpr <pr-number>" >&2
        return 1
    end

    # Create/resolve the PR worktree and grab its path
    set -l wt_path (wt switch "pr:$pr" --no-cd --format json | jq -r '.path')
    if test -z "$wt_path" -o "$wt_path" = null
        echo "wtpr: could not resolve worktree path for pr:$pr" >&2
        return 1
    end

    _wtpr_sync $pr $wt_path

    set -l session "pr-$pr"
    if not tmux has-session -t "=$session" 2>/dev/null
        tmux new-session -d -s $session -c $wt_path # pane 0 (top)
        tmux split-window -v -t "$session:" -c $wt_path # pane 1 (bottom, vim)
        tmux send-keys -t "$session:.1" 'vim .' Enter
        tmux select-pane -t "$session:.0"
        tmux send-keys -t "$session:.0" 'ai /pr-review' Enter
    end

    # Name the Ghostty window "repo - #PR"
    set -l common_dir (git -C $wt_path rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
    set -l repo (basename (dirname $common_dir))
    tmux set-option -t $session @ghostty_title "$repo - #$pr"

    if set -q TMUX
        tmux switch-client -t $session
    else
        tmux attach-session -t $session
        tmux has-session -t "=$session" 2>/dev/null; or exit
    end
end
