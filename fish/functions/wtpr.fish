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

    # Workspace label — herdr shows this in the sidebar and the window title
    set -l common_dir (git -C $wt_path rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
    set -l repo (basename (dirname $common_dir))

    # worktree open is create-or-focus: `already_open` is the idempotence guard, and
    # --label is (re)applied either way, so the label refreshes on every run.
    set -l opened (herdr worktree open --path $wt_path --label "$repo #$pr" --focus)
    or return 1

    set -l top (echo $opened | jq -r '.result.root_pane.pane_id')
    set -l already (echo $opened | jq -r '.result.already_open')

    if test "$already" != true
        # A failed split yields a zero-element list, which would silently collapse
        # the args and make 'vim .' read as the pane id — so check before using it.
        set -l bottom (herdr pane split $top --direction down --cwd $wt_path --no-focus \
            | jq -r '.result.pane.pane_id')
        if test -n "$bottom"
            herdr pane run $bottom 'vim .' >/dev/null
        else
            echo "wtpr: could not split the editor pane" >&2
        end

        # Mirrors conf.d/ai.fish — agent start takes a --kind, not the `ai` alias
        set -l kind claude
        set -l agent_args --dangerously-skip-permissions /pr-review
        if test "$DEV_TOOLS" = cursor
            set kind cursor
            set agent_args --force /pr-review
        end
        # Non-fatal: a startup approval prompt returns agent_not_ready but still
        # leaves a usable pane, and the workspace is worth attaching regardless.
        herdr agent start "pr-$pr" --kind $kind --pane $top -- $agent_args >/dev/null
        or echo "wtpr: agent did not report ready — check the pane" >&2
    end

    # allow_nested is off, so only attach when we aren't already inside herdr
    if not set -q HERDR_ENV
        exec herdr
    end
end
