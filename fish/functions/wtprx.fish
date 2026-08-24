function wtprx --description "close a PR's herdr workspace"
    set -l ws
    if test -n "$argv[1]"
        # Match the label wtpr set. Resolve by label rather than `wt switch`, which
        # would re-create the very worktree we're tearing down. The anchored regex
        # won't cross-match: "PR #112" has a digit, not '#', before the "12".
        set ws (herdr workspace list \
            | jq -r --arg pr $argv[1] \
                '.result.workspaces[] | select(.label | test("#" + $pr + "$")) | .workspace_id' \
            | head -1)
        if test -z "$ws"
            echo "wtprx: no herdr workspace for PR #$argv[1]" >&2
            return 1
        end
    else if set -q HERDR_WORKSPACE_ID
        set ws $HERDR_WORKSPACE_ID
    else
        echo "usage: wtprx <pr-number>  (or run inside the PR workspace)" >&2
        return 1
    end

    # Closes the workspace only — the worktree stays for wtclean/wtsweep to reap.
    herdr workspace close $ws >/dev/null
end
