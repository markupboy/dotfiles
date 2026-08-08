set -gx STARSHIP_CONFIG $DOTFILES/starship/starship.toml

if status is-interactive; and type -q starship
    starship init fish | source
end
