# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

A personal dotfiles repository managing shell configuration, development tools, and
system preferences for macOS and Linux (bare metal and WSL). A long-lived, heavily
deviated fork of Zach Holman's dotfiles structure.

Fish is the login shell; neovim is the editor; starship is the prompt. There is no
build step, no test suite, and no CI — changes are verified by running the setup
scripts and opening a new shell.

## Key Commands

```sh
script/bootstrap   # full setup: gitconfig prompt, symlinks, dot, brew bundle
script/install     # run every topic install.sh (idempotent)
bin/dot            # maintenance: pull, macOS defaults, brew update/upgrade, installers
bin/dot -q         # skip git pull + brew; just relink and re-run installers
bin/dot -e         # open the dotfiles repo in $EDITOR

brew bundle --file=$DOTFILES/homebrew/Brewfile   # install/refresh all packages
```

`dot` and every topic installer depend on `dotlog` (in `bin/`) being on `PATH`.
`script/bootstrap` prepends `./bin` for that reason; `dot` relies on
`fish/conf.d/02-path.fish` having already added `$DOTFILES/bin`. Invoking an
`install.sh` directly from a shell where `$DOTFILES/bin` isn't on `PATH` will fail
on the first `dotlog` call.

Remote one-liner install: `curl -fsSL .../script/remote.sh | bash` — clones to
`~/.dotfiles` and execs `script/bootstrap`.

## Architecture

### Two symlink mechanisms

1. **`*.symlink` files → `~/.<name>`**, linked by `script/bootstrap` (which finds
   them with `find`, prompts on collision, and offers skip/overwrite/backup).
   Example: `git/gitconfig.symlink` → `~/.gitconfig`.
2. **Whole topic directories → `~/.config/<same name>`**, linked by
   `script/link-config` from its `CONFIG_LINKS` list: `fish`, `ghostty`, `nvim`,
   `worktrunk`. Adding a config topic means adding one line to that list — the
   topic directory is named after its `~/.config` entry, so there is no mapping to
   maintain and no per-topic `install.sh`. `script/install` runs it before the
   installer loop.

Both mechanisms must stay idempotent, because `dot` runs them on every invocation.
`link_config` compares `readlink` against the intended target: same target →
`dotlog skip`, stale or broken link → relink, real directory in the way → `dotlog
error` and a non-zero exit (after trying the remaining topics).

A topic only needs an `install.sh` when it does something *other* than config-dir
linking — `git/` (sets `core.excludesFile`), `tmux/` (clones tpm), `homebrew/`
(installs brew), `linux/` (apt build deps).

### Shell configuration

Because `fish/` **is** `~/.config/fish`, fish's own conventions do all the loading —
there is no sourcing loop to maintain:

- `fish/conf.d/*.fish` — auto-sourced in filename order, one file per topic. The
  numeric prefixes are load-bearing: `00-env` defines `$DOTFILES` and platform
  flags, `01-homebrew` must put the Homebrew prefix on `PATH` before later files
  run their `type -q <tool>` guards, `02-path` sets the base `PATH`.
- `fish/config.fish` — sourced last; interactive-only tail.
- `fish/functions/*.fish` — autoloaded on first call, one function per file.
  Anything whose body is a pipeline or takes arguments goes here rather than being
  an alias (see `grm`, `wtpr`, `wtclean`).
- `fish/completions/` — gitignored except `.gitkeep`. Homebrew installs completions
  into its own `vendor_completions.d`, which fish already searches; anything landing
  here is machine-local.

Three rules when adding config:

1. **`conf.d` is sourced for non-interactive shells too.** Wrap aliases, key
   bindings, and prompt setup in `if status is-interactive`. Environment variables
   and `fish_add_path` stay unguarded — `node.fish` deliberately leaves `fnm env`
   unguarded so `fish -c 'node -v'` resolves.
2. **Always pass `-g` to `fish_add_path`.** Its default is a *universal* variable,
   which fish persists to `fish/fish_variables` — inside this repo, where it would
   drift out of sync with the committed config.
3. **Never rely on `conf.d` filename order for behavior between two tools.** Set the
   contested value explicitly. `fzf.fish` sets `FZF_CTRL_R_COMMAND ""` outright so
   atuin keeps `ctrl-r`, rather than depending on which file sorts last.

Since the repo is fish's live config dir, fish writes runtime state into it. The
`.gitignore` covers `fish/fish_variables` and `fish/completions/*` for that reason.

### Bash tooling, not fish

The repo's own tooling — `script/bootstrap`, `script/install`, `script/remote.sh`,
`bin/dot`, `bin/dotlog`, and every `install.sh` — is **bash or POSIX sh**, never
fish, so bootstrapping works on a machine where fish isn't installed yet. Target
bash 3.2 (the version macOS ships): no `globstar` (use `find`), no associative
arrays.

The chicken-and-egg is explicit throughout: fish comes from the Brewfile, so on a
fresh machine `dot` runs before fish exists. `macos/set-shell.sh` and
`fish/install.sh` both no-op quietly in that case and pick it up on the next pass.
Both read the login shell from the passwd/dscl record rather than `$SHELL`, which
goes stale immediately after `chsh`.

### Local overrides

Machine-specific and secret config is gitignored and layered on top:

- `~/.localrc.fish` — sourced by `00-env.fish`; secrets and per-machine env
- `~/.gitconfig.local` — included by `git/gitconfig.symlink`; generated from
  `gitconfig.local.symlink.example` during bootstrap
- `fish/*.local.*`, `ghostty/local.ghostty` — gitignored local additions

### Neovim

`nvim/` → `~/.config/nvim`. `init.lua` holds all options and core keymaps (space
leader, relative numbers, 2-space tabs, undofile, 80-col colorcolumn, trim-on-save
autocmd) and ends by requiring `config.lazy`, which bootstraps lazy.nvim and
imports every file in `nvim/lua/plugins/`. Each plugin file returns a lazy.nvim
spec; adding a plugin means adding a file there, nothing else. `nvim/lazy-lock.json`
is gitignored, so plugin versions are not pinned across machines. `nvim/ftplugin/`
and `nvim/ftdetect/` hold per-filetype settings. See `nvim/CHEATSHEET.md` (and
`tmux/CHEATSHEET.md`) for the keymaps.

### Topic directories

- **atuin/** — `config.toml`; `ATUIN_CONFIG_DIR` points here
- **bin/** — scripts on `PATH`: git helpers (`git-undo`, `git-amend`,
  `git-delete-merged`, `git-force-push`, `git-track-remote`), network tools
  (`getIP`, `dns-flush`), plus `dot` and `dotlog`
- **git/**, **homebrew/**, **starship/**, **tmux/**, **ghostty/** — as named
- **linux/** — Linuxbrew build dependencies for Debian/Ubuntu
- **macos/** — `set-defaults.sh`, `set-hostname.sh`, `set-shell.sh`; run by `dot`,
  *not* by `script/install`
- **worktrunk/** — worktrunk config; drives the `wtpr`/`wtprx`/`wtclean` worktree +
  tmux PR-review workflow in `fish/functions/`

### Tooling

Fish provides syntax highlighting, autosuggestions, and completions natively, so
there is no plugin manager. Notable tools wired up in `conf.d`: **fnm** (node),
**mise**, **atuin** (history search, owns `ctrl-r`), **fzf**, **zoxide** (as `cd`,
disabled under `$CLAUDECODE`), **eza** (aliased over `ls`/`l`/`ll`/`la`), **bat**,
**ripgrep**, **vivid** (`LS_COLORS`, cached at `~/.cache/ls_colors` and regenerated
when `colors.fish` is newer), **starship**, **worktrunk**.
