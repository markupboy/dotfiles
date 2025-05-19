if (( $+commands[uv] ))
then
    echo "UV exists"
    if [[ ! -f ~/.zsh/completions/_uv ]]
    then
        uv generate-shell-completion zsh > ~/.zsh/completions/_uv
    fi
fi