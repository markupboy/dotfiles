# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages shell configuration, development tools, and system preferences for macOS and Linux (both bare metal and WSL). It's a fork of Zach Holman's dotfiles structure with significant customizations.

## Key Commands

### Initial Setup

- `script/bootstrap` - Sets up the entire dotfiles system by symlinking all `.symlink` files to the home directory, configuring git (author name/email from template), and optionally running topic installers
- `script/install` - Finds and runs all `install.sh` scripts in topic directories
- `bin/dot` - Main maintenance command that updates macOS defaults, hostname, and homebrew

### Package Management

- `brew bundle --file=$DOTFILES/homebrew/Brewfile` - Install all applications and command line tools via Homebrew

## Directory Structure

The repository follows a topic-based organization where each directory represents a different area of configuration:

- **atuin/**: Shell history management (Atuin config and zsh integration)
- **bin/**: Utility scripts available in PATH (git helpers like `git-undo`, `git-amend`, `git-delete-merged`; network tools like `getIP`, `dns-flush`; `serve-here` HTTP server; `dotlog` logging utility)
- **ghostty/**: Customizations for the Ghostty terminal
- **git/**: Git configuration, global gitignore, and git aliases (`g`, `gb`, `gc`, `gco`, `gp`, `gl`, `gs`, `gd`, `ga`, etc.)
- **go/**: Go language path configuration
- **homebrew/**: Package management via Brewfile
- **macos/**: macOS-specific settings and preferences
- **node/**: Node.js configuration (uses fnm, not nvm)
- **nvim/**: Neovim configuration managed with lazy.nvim (see Neovim section below)
- **rust/**: Rust toolchain configuration (sources cargo env)
- **script/**: Setup and installation scripts (`bootstrap`, `install`)
- **starship/**: Starship prompt installation and configuration
- **system/**: General system aliases (includes eza-based `ls` replacements) and PATH setup
- **tmux/**: Tmux configuration and aliases (`T`, `Ta`, `Tr`)
- **util/**: General utility scripts and tests
- **zsh/**: Shell configuration with `.zsh` files that are automatically sourced

## Architecture

### Symlink System

Files ending in `.symlink` are automatically linked to the home directory as hidden files during bootstrap. For example:

- `zsh/zshrc.symlink` → `~/.zshrc`
- `git/gitconfig.symlink` → `~/.gitconfig`
- `tmux/tmux.conf.symlink` → `~/.tmux.conf`

### Auto-sourcing

The zsh configuration (`zshrc.symlink`) automatically sources all `*.zsh` files found in any subdirectory of `$ZSH`, allowing modular configuration across topics. This means adding a `.zsh` file to any topic directory will automatically include it.

### Installation System

Each topic directory can contain an `install.sh` script that handles topic-specific setup tasks. These are run by `script/install`.

### Neovim Configuration

Neovim config lives in `nvim/` and is symlinked to `~/.config/nvim` via `nvim/install.sh`.

- `nvim/init.lua` - Main config: space as leader, relative line numbers, 2-space tabs, undofile, 80-char colorcolumn, lazy.nvim bootstrap
- `nvim/colors/onedark_pro_night_flat.lua` - Custom One Dark Pro Night Flat colorscheme (Lua implementation)
- `nvim/lua/plugins/` - Plugin configs managed by lazy.nvim:
  - `colorscheme.lua` - Loads custom colorscheme
  - `telescope.lua` - Fuzzy finder (leader+f bindings)
  - `treesitter.lua` - Syntax highlighting with auto-install for common languages
  - `filexexplorer.lua` - nvim-tree file explorer (leader+e)
  - `statusline.lua` - lualine status bar
  - `indentline.lua` - Visual indent guides
  - `autopair.lua` - Bracket/quote auto-pairing
  - `autotag.lua` - HTML/JSX tag auto-closing

### Shell Plugins and Tools

- **zsh-syntax-highlighting** and **zsh-autosuggestions** - Loaded from Homebrew or system paths depending on platform
- **fnm** - Fast Node Manager (replaced nvm)
- **atuin** - Shell history search and sync
- **eza** - Modern `ls` replacement (aliased over `ls`, `ll`, `la`)
- **vivid** - LS_COLORS generator using "one-dark" theme (cached in `~/.cache/ls_colors`)
- **starship** - Cross-shell prompt

## Important Files

- `zsh/zshrc.symlink` - Main shell configuration that sources all `.zsh` files
- `zsh/config.zsh` - General zsh options (history sharing, prompt substitution, correction)
- `zsh/history.zsh` - History configuration (100k entries)
- `zsh/colors.zsh` - LS_COLORS via vivid with caching
- `system/aliases.zsh` - System-wide aliases including eza-based ls replacements
- `system/path.zsh` - PATH configuration
- `script/bootstrap` - Primary setup script
- `bin/dot` - System maintenance and update script
- `homebrew/Brewfile` - Complete list of applications and tools to install
- `nvim/init.lua` - Neovim entry point
