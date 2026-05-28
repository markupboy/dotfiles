# Update Ghostty tab title to git repo name (or current folder)
set_ghostty_title() {
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -d "$dir/.git" ]]; then
      echo -ne "\e]0;${dir##*/}\a"
      return
    fi
    dir="${dir:h}"
  done

  # Not in a git repo — show last 3 path segments
  local short_path
  short_path=$(echo "$PWD" | awk -F/ '{
    n=NF;
    if(n>=3) print $(n-2)"/"$(n-1)"/"$n;
    else if(n==2) print $(n-1)"/"$n;
    else print $n
  }')
  echo -ne "\e]0;${short_path}\a"
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd set_ghostty_title

# Also run on shell startup so the first tab gets named
set_ghostty_title
