function grm --description 'git rm every file git reports as deleted'
    set -l root (git rev-parse --show-toplevel 2>/dev/null)
    or begin
        echo "grm: not a git repository" >&2
        return 1
    end

    set -l deleted (git diff -z --name-only --diff-filter=D | string split0)
    test (count $deleted) -gt 0
    or return 0

    # paths are root-relative, git rm resolves against cwd
    git -C $root rm -- $deleted
end
