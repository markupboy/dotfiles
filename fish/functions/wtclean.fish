function wtclean --description 'remove worktrees whose branches are merged into main'
    set -l query '.[]
        | select((.is_main or .is_current) | not)
        | select(.main_state == "integrated" or .main_state == "empty")
        | .branch'

    for b in (wt list --format json | jq -r $query)
        wt remove --foreground $b
    end
end
