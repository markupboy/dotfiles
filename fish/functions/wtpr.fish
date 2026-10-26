function wtpr --description 'quickly spawn PR review sessions from a list of identifiers'
    if test (count $argv) -eq 0
        echo "usage: wtpr <pr-number>..." >&2
        return 1
    end

    set -l failed
    for pr in $argv
        if not _wtpr_open $pr
            set -a failed $pr
        end
    end

    if set -q failed[1]
        echo "wtpr: failed: $failed" >&2
        return 1
    end

    # allow_nested is off, so only attach when we aren't already inside herdr
    if not set -q HERDR_ENV
        exec herdr
    end
end
