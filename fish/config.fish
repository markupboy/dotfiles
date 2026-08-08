# Sourced after every conf.d/*.fish. Interactive-only tail.

if status is-interactive
    set -g fish_greeting
end

function add_blank_line --on-event fish_postexec
  echo ""
end
