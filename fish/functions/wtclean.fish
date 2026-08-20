function wtclean --description 'remove worktrees whose branches are merged into the default branch'
    set -l query '.repo.default_branch as $default
        | .items[]
        | select(.branch != null and .branch != $default)
        | select(((.worktree.main // false) or (.worktree.current // false)) | not)
        | select([.worktree.changes.staged,
            .worktree.changes.modified,
            .worktree.changes.untracked,
            .worktree.changes.renamed,
            .worktree.changes.deleted,
            .worktree.changes.conflicted] | any(. == true) | not)
        | [.branch, .display.state, $default]
        | @tsv'

    for candidate in (wt list --format json | jq -r $query)
        set -l fields (string split \t -- $candidate)
        set -l branch $fields[1]
        set -l state $fields[2]
        set -l default_branch $fields[3]
        set -l remove_args --foreground
        set -l force_delete false

        if not contains -- $state integrated empty
            type -q gh; or continue
            set -l head (git rev-parse --verify "refs/heads/$branch" 2>/dev/null)
            or continue
            gh pr list --state merged --base $default_branch --head $branch \
                --json headRefOid --limit 100 \
                --jq '.[].headRefOid' 2>/dev/null \
                | string match -qx -- $head
            or continue
            set -a remove_args -D
            set force_delete true
        end

        if test $force_delete = true
            set -l current_head (git rev-parse --verify "refs/heads/$branch" 2>/dev/null)
            test "$current_head" = "$head"
            or continue
        end

        wt remove $remove_args $branch
    end
end
