# --cmd cd replaces the old `alias cd='z'`, so `cd` is zoxide-aware directly.

if status is-interactive; and type -q zoxide; and not set -q CLAUDECODE
    zoxide init fish --cmd cd | source
end
