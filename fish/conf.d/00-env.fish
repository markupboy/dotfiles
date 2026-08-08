# Core environment. Runs before every other conf.d file.

set -gx DOTFILES $HOME/.dotfiles
set -gx EDITOR nvim

# Platform detection
switch (uname -s)
    case Linux
        if grep -qi microsoft /proc/version 2>/dev/null
            set -gx WIN 1
        else
            set -gx LINUX 1
        end
end

# use ~/.localrc.fish for SUPER SECRET stuff that you don't
# want in your public, versioned repo.
if test -f ~/.localrc.fish
    source ~/.localrc.fish
end
