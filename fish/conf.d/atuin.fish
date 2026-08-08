set -gx ATUIN_CONFIG_DIR $DOTFILES/atuin

if status is-interactive; and type -q atuin
    atuin init fish --disable-up-arrow | source
end
