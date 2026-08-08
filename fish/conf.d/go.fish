if test -d /opt/homebrew/opt/go/libexec
    set -gx GOROOT /opt/homebrew/opt/go/libexec
else if type -q go
    set -gx GOROOT (go env GOROOT)
end

set -gx GOPATH $HOME/Code/go

fish_add_path -g $GOPATH/bin $GOROOT/bin
