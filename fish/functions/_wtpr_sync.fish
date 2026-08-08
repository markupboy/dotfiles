function _wtpr_sync --description "fast-forward a PR worktree to the PR's current head"
    set -l pr $argv[1]
    set -l wt_path $argv[2]

    # detached HEAD — nothing to fast-forward
    git -C $wt_path symbolic-ref --quiet HEAD >/dev/null; or return 0

    # -uno so /pr-review's untracked review_*.md files don't block the pull
    set -l dirty (git -C $wt_path status --porcelain -uno)
    if test (count $dirty) -gt 0
        echo "wtpr: worktree has uncommitted changes — skipping pull" >&2
        return 0
    end

    if not git -C $wt_path fetch --quiet origin "refs/pull/$pr/head"
        echo "wtpr: could not fetch refs/pull/$pr/head — skipping pull" >&2
        return 0
    end

    set -l before (git -C $wt_path rev-parse HEAD)
    set -l head (git -C $wt_path rev-parse FETCH_HEAD)
    test "$before" = "$head"; and return 0

    # Swallow git's "can't be fast-forwarded" advice block
    if git -C $wt_path merge --ff-only --quiet FETCH_HEAD 2>/dev/null
        set -l pulled (git -C $wt_path rev-list --count $before..HEAD)
        set -l short (git -C $wt_path rev-parse --short HEAD)
        echo "wtpr: pulled $pulled new commit(s) → $short"
    else
        echo "wtpr: local branch has diverged from PR #$pr — skipping pull" >&2
    end
end
