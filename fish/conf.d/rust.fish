if test -f $HOME/.cargo/env.fish
    source $HOME/.cargo/env.fish
else if test -d $HOME/.cargo/bin
    fish_add_path -g $HOME/.cargo/bin
end
