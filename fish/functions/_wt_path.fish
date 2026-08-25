function _wt_path --description "path of the worktree checked out at a branch"
    # A pruned worktree keeps its row in `wt list`, so confirm the checkout is there.
    set -l p (wt list --format json \
        | jq -r --arg b "$argv[1]" '.items[] | select(.branch == $b) | .worktree.path // empty' \
        | head -1)
    test -d "$p"; and echo $p
end
