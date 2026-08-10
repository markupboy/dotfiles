![Screenshot](https://raw.githubusercontent.com/markupboy/dotfiles/main/.github/images/screenshot.jpg)

## Installation

### Automated

```sh
curl -fsSL https://raw.githubusercontent.com/markupboy/dotfiles/main/script/remote.sh | bash
```

### Manual

- `xcode-select --install`
- `git clone https://github.com/markupboy/dotfiles.git ~/.dotfiles`
- `cd ~/.dotfiles`
- `script/bootstrap`

The bootstrap script will set up a gitconfig, symlink the appropriate
files in `.dotfiles` to your home and .config directories, then run `dot`,
which runs every topic install script.

The `dot` command will sync any changes, rerun the topic installers,
and, on MacOS, set OS defaults and tend to homebrew updates.

Setup and refresh commands like `bootstrap` and `dot` will ensure fish is the
default shell.

The Brewfile covers fish, neovim, and worktrunk; Ghostty is not in it, so install
the terminal itself for your platform.

Be sure to install the [`consolas-powerline`](https://github.com/markupboy/consolas-powerline)
font for the full experience.

## Credits

This had long been a much deviated fork of [Zach Holman's dotfiles](https://github.com/holman/dotfiles)
until the shift to [Fish](https://fishshell.com/) in 2026. Credit to Zach for
the inspiration and some of the remaining code.
