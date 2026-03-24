if [[ -d "/opt/homebrew/opt/go/libexec" ]]; then
  export GOROOT="/opt/homebrew/opt/go/libexec"
elif command -v go &>/dev/null; then
  export GOROOT="$(go env GOROOT)"
fi
export GOPATH=$HOME/Code/go
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
