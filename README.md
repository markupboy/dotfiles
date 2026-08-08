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
files in `.dotfiles` to your home and .config directores, and optionally run
the subtopic install scripts.

The `dot` command will sync any changes, rerun the topic installers,
and, on MacOS, set OS defaults and tend to homebrew updates.

`script/link-config` links `fish/`, `ghostty/`, `nvim/`, and `worktrunk/` to the
matching directories under `~/.config`; adding another is one line in its
`CONFIG_LINKS` list. On macOS, `dot` makes fish your login shell via
`macos/set-shell.sh` once it's installed — it registers fish in `/etc/shells` and
runs `chsh`, and does nothing at all if fish is already the login shell. The
repo's own tooling (`script/bootstrap`, `bin/dot`, the topic installers) is bash,
so it still runs on a machine where fish isn't installed yet.

The Brewfile covers fish, neovim, and worktrunk; Ghostty is not in it, so install
the terminal itself for your platform.

Be sure to install the `Consolas` and `Consolas Nerd Font Mono` fonts for
the full experience.

## Credits

This has been a long-lived (now more than 15 years 🎉), much deviated
fork of [Zach Holman's dotfiles](https://github.com/holman/dotfiles).
Credit to him for the structure, some of the code, and the inspiration.
