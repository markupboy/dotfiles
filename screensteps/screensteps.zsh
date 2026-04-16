# mise activation
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# add mysql client to PATH
if [ -d "/opt/homebrew/opt/mysql-client/bin" ]; then
  export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
fi