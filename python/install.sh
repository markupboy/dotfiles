#!/usr/bin/env bash

if command -v uv >/dev/null 2>&1
then
    if [[ ! -f ~/.zsh/completions/_uv ]]
    then
        mkdir -p ~/.zsh/completions
        uv generate-shell-completion zsh > ~/.zsh/completions/_uv
    fi
fi