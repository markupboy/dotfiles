# fnm
export PATH="/Users/blake/.local/state/fnm_multishells/43474_1774018937226/bin":$PATH
export FNM_MULTISHELL_PATH="/Users/blake/.local/state/fnm_multishells/43474_1774018937226"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_DIR="/Users/blake/.local/share/fnm"
export FNM_LOGLEVEL="info"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_COREPACK_ENABLED="false"
export FNM_RESOLVE_ENGINES="true"
export FNM_ARCH="arm64"
rehash

# pnpm
export PNPM_HOME="/Users/blake/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac