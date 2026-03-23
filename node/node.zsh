# fnm
eval "$(fnm env --use-on-cd)"

# pnpm
export PNPM_HOME="/Users/blake/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac