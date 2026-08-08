# Homebrew must run first

for brew_prefix in /opt/homebrew /home/linuxbrew/.linuxbrew $HOME/.linuxbrew
    if test -x $brew_prefix/bin/brew
        $brew_prefix/bin/brew shellenv fish | source
        break
    end
end
set -e brew_prefix
