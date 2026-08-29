# Cache vivid output for performance.
if type -q vivid
    set -l cache $HOME/.cache/ls_colors
    set -l src (status filename)

    if not test -f $cache; or test (path mtime $src) -gt (path mtime $cache)
        mkdir -p $HOME/.cache
        vivid generate dracula >$cache
    end

    set -gx LS_COLORS (cat $cache)
end
