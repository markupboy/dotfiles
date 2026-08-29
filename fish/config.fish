# Sourced after every conf.d/*.fish. Interactive-only tail.

if status is-interactive
    # bobthefish defines its own fish_greeting function, which shadows $fish_greeting
    function fish_greeting
        echo
    end
end

function add_blank_line --on-event fish_postexec
  echo ""
end
