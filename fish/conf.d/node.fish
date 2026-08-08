# fnm — unguarded by `status is-interactive` so `fish -c 'node -v'` resolves.
if type -q fnm
    fnm env --use-on-cd --shell fish | source
end

# pnpm
if test (uname) = Darwin
    set -gx PNPM_HOME $HOME/Library/pnpm
else
    set -l xdg_data $HOME/.local/share
    if set -q XDG_DATA_HOME
        set xdg_data $XDG_DATA_HOME
    end
    set -gx PNPM_HOME $xdg_data/pnpm
end

fish_add_path -g $PNPM_HOME

if status is-interactive
    alias nvm fnm
end
