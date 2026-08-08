if status is-interactive
    set -l ai_cli "claude --dangerously-skip-permissions"
    if test "$AI_CLI" = cursor
        set ai_cli "cursor-agent --force"
    end

    alias ai "$ai_cli"
end
