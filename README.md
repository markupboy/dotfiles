## install

- `git clone https://github.com/markupboy/dotfiles.git ~/.dotfiles`
- `cd ~/.dotfiles`
- `script/bootstrap`

The bootstrap script will set up a gitconfig, symlink the appropriate
files in `.dotfiles` to your home directory, and optionally run the
subtopic install scripts.

The `dot` command will sync any changes, rerun the topic installers,
and, on MacOS, set OS defaults and tend to homebrew updates.

These dotfiles assume/require neovim, Starship prompt, and the zsh
plugins zsh-auto-suggestions and zsh-syntax-highlighting.

## credits

This has been a long-lived, now much deviated fork of
[Zach Holman's dotfiles](https://github.com/holman/dotfiles). Credit
to him for the structure, some of the code, and the inspiration.
