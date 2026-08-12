function wtclean --description 'remove worktrees whose branches are merged into main'
    set -l query '.repo.default_branch as $default
        | .items[]
        | select(.branch != null and .branch != $default)
        | select((((.worktree.main // false) or (.worktree.current // false))) | not)
        | select(.display.state == "integrated" or .display.state == "empty")
        | .branch'

    for b in (wt list --format json | jq -r $query)
        wt remove --foreground $b
    end
end
