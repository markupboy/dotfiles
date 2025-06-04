# windows specific configuration
if [[ $WIN ]]
then
    export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
    export PATH="$PATH:/mnt/c/Program\ Files/Docker/Docker/resources/bin"
    alias docker=docker.exe
    alias docker-compose=docker-compose.exe
    alias ssh='ssh.exe'
    alias ssh-add='ssh-add.exe'
fi

if [[ -a /home/linuxbrew/.linuxbrew/bin ]]
then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    umask 002
fi