# windows (WSL) specific configuration

if set -q WIN
    fish_add_path -g $HOME/bin $HOME/.local/bin
    fish_add_path -ga "/mnt/c/Program Files/Docker/Docker/resources/bin"

    if status is-interactive
        alias docker docker.exe
        alias docker-compose docker-compose.exe
        alias ssh ssh.exe
        alias ssh-add ssh-add.exe
    end
end

# Linuxbrew's PATH is handled in 01-homebrew.fish; only the umask remains.
if test -d /home/linuxbrew/.linuxbrew/bin
    umask 002
end
