#commands
alias rm='rm -i'
alias c='clear'
alias top='top -o cpu'
alias getip="getIP"
alias whatismyip="getip"

# eza overides for ls
if command -v eza &>/dev/null
then
  alias ls="eza --icons --group-directories-first"
  alias l="eza --icons --group-directories-first -lAh"
  alias ll="eza --icons --group-directories-first -l"
  alias la='eza --icons --group-directories-first -A'
fi

# ripgrep aliases
if command -v rg &>/dev/null
then
  alias search="rg"
  alias ag="rg"
fi

# bat overrides for cat
if command -v bat &>/dev/null
then
  alias cat="bat"
fi


#nocorrect when you might get a new dir or file
alias vim='nocorrect nvim'
alias touch='nocorrect touch'
alias mv='nocorrect mv -i'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

# Pipe my public key to my clipboard
getkey() {
  local keyfile
  if [[ -f ~/.ssh/id_ed25519.pub ]]; then
    keyfile=~/.ssh/id_ed25519.pub
  elif [[ -f ~/.ssh/id_rsa.pub ]]; then
    keyfile=~/.ssh/id_rsa.pub
  else
    echo "Error: No public key found (~/.ssh/id_ed25519.pub or ~/.ssh/id_rsa.pub)" >&2
    return 1
  fi

  if command -v pbcopy &>/dev/null; then
    cat "$keyfile" | pbcopy && echo "=> Public key copied to pasteboard."
  elif command -v xclip &>/dev/null; then
    cat "$keyfile" | xclip -selection clipboard && echo "=> Public key copied to clipboard."
  elif command -v wl-copy &>/dev/null; then
    cat "$keyfile" | wl-copy && echo "=> Public key copied to clipboard."
  elif [[ -n $WIN ]]; then
    cat "$keyfile" | clip.exe && echo "=> Public key copied to clipboard."
  else
    echo "Error: No clipboard command found" >&2
    return 1
  fi
}

