function wtpr --description 'quickly spawn a PR review session from an identifier'
    set -l pr $argv[1]
    if test -z "$pr"
        echo "usage: wtpr <pr-number>" >&2
        return 1
    end

    # worktrunk resolves pr:N itself, but only it knows the branch afterwards.
    set -l branch (gh pr view $pr --json headRefName --jq .headRefName)
    or return 1

    # Uncaptured: the post-start hook copies ignored files, and that is slow enough
    # that swallowing its output reads as a hung shell.
    wt switch "pr:$pr" --no-cd
    or return 1

    set -l wt_path (_wt_path $branch)
    if test -z "$wt_path"
        echo "wtpr: could not resolve worktree path for pr:$pr" >&2
        return 1
    end

    _wtpr_sync $pr $wt_path
    _wt_herdr_open $wt_path "PR #$pr" "pr-$pr" /pr-review
    or return 1

    # allow_nested is off, so only attach when we aren't already inside herdr
    if not set -q HERDR_ENV
        exec herdr
    end
end
