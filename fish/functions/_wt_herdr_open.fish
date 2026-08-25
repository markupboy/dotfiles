function _wt_herdr_open --description "open a worktrunk checkout as a herdr workspace running an agent"
    set -l wt_path $argv[1]
    set -l label $argv[2]
    set -l agent $argv[3]
    set -l prompt $argv[4..-1]

    # herdr matches --path against a repo it already tracks, so it needs the repo to
    # resolve against; without --cwd it just answers worktree_not_found.
    set -l src (herdr worktree list --cwd $wt_path)
    or return 1
    set -l repo_root (echo $src | jq -r '.result.source.repo_root')
    set -l parent (echo $src | jq -r '.result.source.source_workspace_id // empty')

    # Left to itself herdr names an auto-created parent after the directory basename.
    if test -z "$parent"
        set -l repo (echo $src | jq -r '.result.source.repo_name' | string replace -r '\.git$' '')
        herdr workspace create --cwd $repo_root --label $repo --no-focus >/dev/null
        or return 1
    end

    # Opening the repo's own checkout would rename that workspace to the branch.
    set -l label_args --label $label
    if test (path resolve $wt_path) = (path resolve $repo_root)
        set label_args
    end

    set -l opened (herdr worktree open --cwd $repo_root --path $wt_path $label_args --no-focus)
    or return 1
    set -l ws (echo $opened | jq -r '.result.workspace.workspace_id')

    if test (echo $opened | jq -r '.result.already_open') != true
        set -l top (echo $opened | jq -r '.result.root_pane.pane_id')

        # A failed split yields a zero-element list, which would silently collapse
        # the args and make 'vim .' read as the pane id — so check before using it.
        set -l bottom (herdr pane split $top --direction down --cwd $wt_path --no-focus \
            | jq -r '.result.pane.pane_id')
        if test -n "$bottom"
            herdr pane run $bottom 'vim .' >/dev/null
        else
            echo "$agent: could not split the editor pane" >&2
        end

        _wt_herdr_agent $agent $top $wt_path $prompt
    end

    # Focus last — until the layout is built, the pane we were called from is busy.
    herdr workspace focus $ws >/dev/null
end
