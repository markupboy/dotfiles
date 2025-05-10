## install

- `git clone https://github.com/markupboy/dotfiles.git ~/.dotfiles`
- `cd ~/.dotfiles`
- `script/bootstrap`

The bootstrap script will symlink the appropriate files in `.dotfiles` to your
home directory. Everything is configured and tweaked within `~/.dotfiles`,
though.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

## credits

This has been a long-lived fork of [Zach Holman's dotfiles](https://github.com/holman/dotfiles).
Credit to him for the structure, some of the code, and the inspiration.
