function wtc --description 'create a worktree and open it as a herdr workspace running an agent'
    set -l branch $argv[1]
    if test -z "$branch"
        # Bare `wt switch` opens an fzf picker, which has nowhere to draw from here.
        echo "usage: wtc <branch>" >&2
        return 1
    end

    # Uncaptured: the post-start hook copies ignored files, and that is slow enough
    # that swallowing its output reads as a hung shell.
    wt switch --create $branch --no-cd
    or return 1

    set -l wt_path (_wt_path $branch)
    if test -z "$wt_path"
        echo "wtc: could not resolve worktree path for $branch" >&2
        return 1
    end

    # Agent names must match [a-z][a-z0-9_-]{0,31}; branch names need not.
    set -l agent (string join '' wt- (string lower -- $branch | string replace -ra '[^a-z0-9]+' -) \
        | string sub -l 32)

    _wt_herdr_open $wt_path $branch $agent
    or return 1

    if not set -q HERDR_ENV
        exec herdr
    end
end
