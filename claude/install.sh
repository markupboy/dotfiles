#!/bin/zsh
set -e

script_dir=$(dirname "$(realpath "$0")")
claude_dir="$HOME/.claude"
mkdir -p "$claude_dir"

# ~/.claude also holds runtime state (projects/, plugins/, skills/), so we
# link individual config files rather than the directory itself.
link_claude() {
  local src="$1" dst="$2"
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    dotlog "skip" "Skipping $dst"
    return
  fi
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    local backup="$dst.backup.$(date +%Y%m%d%H%M%S)"
    dotlog "info" "Backing up $dst to $backup"
    mv "$dst" "$backup"
  fi
  ln -sfn "$src" "$dst"
  dotlog "install" "Linked $dst"
}

chmod +x "$script_dir/statusline.sh" "$script_dir/hooks/"*.sh

link_claude "$script_dir/settings.json" "$claude_dir/settings.json"
link_claude "$script_dir/CLAUDE.md"     "$claude_dir/CLAUDE.md"
link_claude "$script_dir/statusline.sh" "$claude_dir/statusline.sh"
link_claude "$script_dir/hooks"         "$claude_dir/hooks"
