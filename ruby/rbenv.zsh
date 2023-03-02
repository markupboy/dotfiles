if [[ -a ~/.rbenv ]]
then
  export PATH=~/.rbenv/shims:$PATH
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi