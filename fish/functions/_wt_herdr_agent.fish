function _wt_herdr_agent --description "start an agent in a herdr pane, clearing its startup trust prompt"
    set -l agent $argv[1]
    set -l pane $argv[2]
    set -l wt_path $argv[3]
    set -l prompt $argv[4..-1]

    # Mirrors conf.d/ai.fish — agent start takes a --kind, not the `ai` alias
    set -l kind claude
    set -l flags --dangerously-skip-permissions
    if test "$DEV_TOOLS" = cursor
        set kind cursor
        set flags --force
    end

    set -l err (herdr agent start $agent --kind $kind --pane $pane --timeout 5000 -- $flags $prompt 2>&1 >/dev/null)
    test -z "$err"; and return 0

    # A checkout worktrunk just made is a directory the agent has never seen, so it
    # opens on its "do you trust this folder" prompt — which the skip-permissions
    # flags above do not cover. agent start reports that as agent_not_ready but keeps
    # the name registered, so answer it rather than parking the user on a dialog.
    # This is the expected path, so the timeout above is short rather than herdr's 30s.
    if string match -q '*agent_not_ready*' -- "$err"
        echo "$agent: trusting $wt_path"
        herdr agent send-keys $agent enter >/dev/null
        and herdr agent wait $agent --timeout 30000 >/dev/null
        and return 0
    end

    echo "$agent: agent did not start — $err" >&2
    return 0
end
