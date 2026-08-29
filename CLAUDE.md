# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

A personal dotfiles repository managing shell configuration, development tools, and
system preferences for macOS and Linux (bare metal and WSL). A long-lived, heavily
deviated fork of Zach Holman's dotfiles structure.

Fish is the login shell; neovim is the editor; bobthefish is the prompt. There is no
build step, no test suite, and no CI — changes are verified by running the setup
scripts and opening a new shell.

## Conventions

Comments are sparse here on purpose. Most functions and config files have none.
Write one only when the code is genuinely non-obvious, keep it to a single short
line, and never add a multi-line block reconstructing the reasoning behind a
change — that belongs in the commit message, or in this file when it's a
standing architectural fact.

## Key Commands

```sh
script/bootstrap   # full setup: gitconfig prompt, symlinks, dot, brew bundle
script/install     # run every topic install.sh (idempotent)
bin/dot            # maintenance: pull, macOS defaults, brew update/upgrade, installers
bin/dot -q         # skip git pull + brew; just relink and re-run installers

brew bundle --file=$DOTFILES/homebrew/Brewfile   # install/refresh all packages
```

`dot` takes only `-q`/`--quick` and `-h`/`--help`. Opening the repo is a shell
alias, not a flag: `dotcd`, `dotvim`, `dotcode` in `fish/conf.d/dotfiles.fish`.

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
   `script/link-config` from its `CONFIG_LINKS` list: `fish`, `ghostty`, `herdr`,
   `nvim`, `worktrunk`. Adding a config topic means adding one line to that list — the
   topic directory is named after its `~/.config` entry, so there is no mapping to
   maintain and no per-topic `install.sh`. `script/install` runs it before the
   installer loop.

Both mechanisms must stay idempotent, because `dot` runs them on every invocation.
`link_config` compares `readlink` against the intended target: same target →
`dotlog skip`, stale or broken link → relink, real directory in the way → `dotlog
error` and a non-zero exit (after trying the remaining topics).

A topic only needs an `install.sh` when it does something *other* than config-dir
linking — `tmux/` (clones tpm), `fish/` (clones bobthefish), `homebrew/` (installs
brew), `linux/` (apt build deps), `herdr/` (installs the worktrunk plugin). `git/`
has none: its settings are declared in the tracked `gitconfig.symlink`, and `git
config --global` would write *into* that file (`~/.gitconfig` symlinks to it), so an
installer there only churns the repo.

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
fresh machine `dot` runs before fish exists. `macos/set-shell.sh` no-ops quietly in
that case and picks it up on the next pass. It reads the login shell from the
passwd/dscl record rather than `$SHELL`, which goes stale immediately after `chsh`.

### Local overrides

Machine-specific and secret config is gitignored and layered on top:

- `~/.localrc.fish` — sourced by `00-env.fish`; secrets and per-machine env
- `~/.gitconfig.local` — included by `git/gitconfig.symlink`; generated from
  `gitconfig.local.symlink.example` during bootstrap
- `ghostty/local.ghostty` — gitignored, pulled in by `config-file = ?local.ghostty`

`DEV_TOOLS` is the work-vs-personal switch. Put `set -gx DEV_TOOLS cursor` in
`~/.localrc.fish` and `conf.d/ai.fish` runs `cursor-agent`, `wtpr` starts herdr
agents with `--kind cursor`, and `conf.d/system.fish` aliases `code` to `cursor
--classic`. Unset, everything defaults to claude and VS Code. `00-env.fish`
resolves it just after sourcing `~/.localrc.fish` and still accepts the previous
name, `AI_CLI`. The `code` alias additionally requires `type -q cursor`, so a
machine where the Cursor CLI isn't installed keeps a working `code` instead of
shadowing it with a missing binary.

There is no per-file local override for fish: `conf.d` is fish's own load mechanism,
so machine-local fish config goes in `~/.localrc.fish`.

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
  `git-delete-merged`, `git-force-push`), `wtsweep` (worktree/branch cleanup, see
  worktrunk below), network tools (`getIP`, `dns-flush`), `getkey` (SSH public key
  to clipboard, falling back to the 1Password CLI), plus `dot` and `dotlog`
- **git/**, **homebrew/**, **ghostty/** — as named
- **tmux/** — still here on purpose. The herdr migration (`bceb4c4`, `7d40d97`)
  moved the worktree/PR-review workflow off tmux but did not retire tmux itself,
  so `tmux.conf.symlink`, `install.sh` (which clones tpm on every `dot` run),
  `CHEATSHEET.md`, and the `T`/`Ta`/`Tr` aliases in `conf.d/tmux.fish` all stay.
- **herdr/** — herdr config (agent workspace multiplexer). `config.toml` sets the
  Dracula Pro palette via a `[theme.custom]` override on the built-in
  `dracula` base, so herdr matches nvim, ghostty, and bobthefish. `panel_bg =
  "reset"` is deliberate: it leaves pane backgrounds to ghostty so
  `background-opacity`/`background-blur` still apply. `[ui] accent` is a *separate*
  setting from `[theme.custom] accent` and defaults to `cyan`, so it is set
  explicitly. The two hold different values on purpose: `[ui] accent` is the blue,
  `[theme.custom] accent` the green. Like `fish/`, this directory is herdr's live
  config dir — it writes `session.json`, `.plugins.lock`, `herdr.sock`,
  `herdr-*.log`, and the `plugins/` tree plus `plugins.json` here, all gitignored —
  `plugins/github/*/` is a full git clone. `herdr/install.sh` reinstalls the
  `herdr-worktrunk` plugin instead, which backs the `wtc`/`wtpr` workspace layout.
  Validate with `herdr config check` (it names unknown keys); reload a running server
  with `herdr server reload-config` or `prefix+shift+r`.

  `wtpr`/`wtc`/`wtprx` script herdr over its socket API. Every
  `workspace`/`tab`/`pane`/`agent`/`worktree` command already prints one line of JSON
  to stdout — `--json` is a no-op — and reports failure as JSON on stderr with exit 1
  (a CLI syntax error exits 2), so `jq` plus `or return 1` is the whole error
  contract. IDs are opaque handles (`w1`, `w1:t1`, `w1:p1`) that must be read out of
  the responses — `.result.root_pane.pane_id` on open, `.result.pane.pane_id` on
  split — never constructed by hand. Note `herdr api schema` **understates** the
  responses: it omits `root_pane` and `tab` from `worktree_opened`, which the server
  does send. Trust a live response over the schema.

  `herdr worktree open` is create-or-focus — its `already_open` field is the
  idempotence guard, and `--label` is re-applied on reuse — but it resolves `--path`
  only against a repo it already tracks, so **it needs `--cwd <repo_root>`**. Without
  it the call fails `worktree_not_found`, and passing the *worktree's* own workspace
  is rejected too: a linked-worktree workspace can't be a source. Resolve the root
  with `herdr worktree list --cwd <checkout>` (`.result.source.repo_root`) and, when
  `.result.source.source_workspace_id` is absent, pre-create the parent with
  `herdr workspace create --cwd <root> --label <repo>` — left alone herdr auto-creates
  it labelled with the directory basename, which is where stray workspaces come from.
  `_wt_herdr_open` does all of this; `wtpr` and `wtc` just call it.

  Panes only split `right` or `down`; there is no `left`/`up`. `herdr agent start`
  needs a pane already sitting at an interactive prompt and blocks until the agent is
  ready (30s default), so it takes a `--kind` rather than the `ai` alias — meaning
  `conf.d/ai.fish`'s `DEV_TOOLS=cursor` switch has to be mirrored by hand in
  `_wt_herdr_agent`. A checkout worktrunk just created is a directory the agent has
  never seen, so it opens on its trust prompt — which `--dangerously-skip-permissions`
  does *not* cover. `agent start` reports that as `agent_not_ready` but keeps the name
  registered, so `_wt_herdr_agent` answers it with `agent send-keys <name> enter` and
  then `agent wait`. Focus the workspace *after* the layout is built, not via
  `worktree open --focus`: focusing first strands the calling pane mid-run, which is
  what made these functions look like they hung.
  `HERDR_ENV=1` is the "am I inside herdr" guard (the `$TMUX` analogue), alongside
  `HERDR_WORKSPACE_ID`/`HERDR_TAB_ID`/`HERDR_PANE_ID`. Since `[experimental]
  allow_nested` is off, bare `herdr` may only be run when `HERDR_ENV` is unset.
- **linux/** — Linuxbrew build dependencies for Debian/Ubuntu
- **macos/** — `set-defaults.sh`, `set-hostname.sh`, `set-shell.sh`; run by `dot`,
  *not* by `script/install`
- **worktrunk/** — worktrunk config; drives the `wtpr`/`wtprx`/`wtclean` worktree +
  herdr PR-review workflow in `fish/functions/`. The two tools own separate halves:
  worktrunk creates and removes worktrees, herdr owns the workspace/pane topology. So
  `wtprx` closes a herdr workspace and deliberately leaves the worktree alone — that
  stays with `wtclean`/`wtsweep`/`wt remove`. The `wt` shell integration is an
  autoloaded stub at `fish/functions/wt.fish`, generated by `wt config shell install
  fish` — it sources the full definition from the binary on first call. Putting it in
  `conf.d` instead is deprecated and forks a `wt` subprocess on every shell startup.
  `fish/conf.d/worktrunk.fish` holds only the `wtl` alias — `wtc` takes an argument
  and needs a guard (a bare `wt switch` opens an fzf picker with nowhere to draw), so
  it lives in `fish/functions/` with the rest. Completions come from Homebrew's
  `vendor_completions.d`, so `wt config show` reporting "Completions not configured"
  is a false negative — it only looks in `~/.config/fish/completions`.

  `wtc` and `wtpr` run `wt switch` **uncaptured**. The `[post-start]` hook copies
  ignored files into the new checkout, and swallowing that output in a command
  substitution reads as a hung shell — so the path is looked up afterwards with
  `_wt_path` instead. worktrunk always creates the checkout and runs the hooks first;
  herdr only registers the finished directory with `herdr worktree open`. Never
  `herdr worktree create`, which would cut worktrunk out and skip the hooks.

  Two things sweep merged worktrees and branches, both by asking `wt list --format
  json` for rows whose state is `integrated` or `empty` and feeding them to `wt
  remove`: `wtclean` (fish function, current repo) and `bin/wtsweep` (bash, adds
  `--dry-run`, a `git fetch --prune` first, and multi-repo mode — run it in a
  directory that isn't a repo and it sweeps each immediate child that is one). Both
  filters must exclude `repo.default_branch` **by name**, not just rows where
  `worktree.main` is true: when a repo's primary worktree sits on a feature branch,
  the default branch is an ordinary row that reads as `integrated` into itself, and
  a filter keyed only on `worktree.main` will happily delete it. Both also depend on
  `[list] json-schema = 2` in `config.toml` — the schema 1 field names (`is_main`,
  `main_state`) make jq error out against the schema 2 envelope.

The palette is duplicated across four files by hand. `ghostty/themes/dracula-pro.conf`
is the source for the seven Dracula Pro hues. `nvim/colors/dracula_pro.lua` (including
its `M.terminal` table), `herdr/config.toml`, and
`fish/functions/bobthefish_colors.fish` copy them. Dracula has no blue, so the `blue`
role everywhere is Dracula's purple `#9580ff` and the `purple` role is its pink
`#ff80bf` — that keeps the ANSI slots correct while preserving seven distinct hues.
The selection `#454158`, the comment `#7970a9`, and the seven hues are upstream. The
background is `#1c1b24` — Pro's `#22212c` scaled to 82%, keeping its hue and
saturation — and the rest of the grey ramp is interpolated between the two, so
darkening the background again means recomputing `bg1`/`bg2`/`guide` off it.
Change a hue in one file, change it in all four.

### Tooling

Fish provides syntax highlighting, autosuggestions, and completions natively, so
there is no plugin manager. Notable tools wired up in `conf.d`: **fnm** (node),
**mise**, **atuin** (history search, owns `ctrl-r`), **fzf**, **zoxide** (as `cd`,
disabled under `$CLAUDECODE`), **eza** (aliased over `ls`/`l`/`ll`/`la`), **bat**,
**ripgrep**, **vivid** (`LS_COLORS`, cached at `~/.cache/ls_colors` and regenerated
when `colors.fish` is newer), **worktrunk**.

The Brewfile is formulae only — casks break too often on update to be worth
declaring. The cost is `op`: 1Password's CLI ships only as a cask, so `bin/getkey`
can't have it installed for it and guards with `command -v op` instead. Ghostty is
absent for the same reason and is called out in the README.

**mise** is deliberately not in the Brewfile. It's installed per-machine on the
other systems that share this repo, not on every one, and `mise.fish` is `type -q`
guarded so it no-ops where mise is absent. Adding `brew "mise"` would install it
everywhere, including machines where fnm already covers node.

The prompt is **bobthefish**, cloned by `fish/install.sh` into
`~/.local/share/theme-bobthefish` and put on `$fish_function_path` by
`fish/conf.d/prompt.fish`, which also holds the `theme_*` settings. It is a
vendored directory of autoloadable fish functions, not an oh-my-fish install —
there is still no plugin manager.
