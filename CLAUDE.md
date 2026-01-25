# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages shell configuration, development tools, and system preferences for macOS and linux (both on bare metal and on windows subsystem linux). It's a fork of Zach Holman's dotfiles structure with significant customizations.

## Key Commands

### Initial Setup

- `script/bootstrap` - Sets up the entire dotfiles system by symlinking all `.symlink` files to the home directory and configuring git
- `bin/dot` - Main maintenance command that updates macOS defaults, hostname, homebrew, and runs all installers

### Package Management

- `brew bundle --file=$DOTFILES/homebrew/Brewfile` - Install all applications and command line tools via Homebrew

### Directory Structure

The repository follows a topic-based organization where each directory represents a different area of configuration:

- **bin/**: Utility scripts available in PATH (git helpers, network tools, etc.)
- **ghostty/**: Customizations for the Ghostty terminal
- **git/**: Git configuration with `.symlink` files that become dotfiles in home directory
- **macos/**: macOS-specific settings and preferences
- **homebrew/**: Package management via Brewfile
- **nvim/**: Neovim configuration
- **python/**, **node/**, **go/**: Language-specific configurations
- **starship/**: Starship prompt installation and configuration
- **system/**: General system aliases and pathing that don't have more specific homes
- **util/**: General utility scripts and tests
- **zsh/**: Shell configuration with `.zsh` files that are automatically sourced

## Architecture

### Symlink System

Files ending in `.symlink` are automatically linked to the home directory as hidden files. For example:

- `zsh/zshrc.symlink` → `~/.zshrc`
- `git/gitconfig.symlink` → `~/.gitconfig`

### Auto-sourcing

The zsh configuration automatically sources all `.zsh` files in any subdirectory, allowing modular configuration across topics.

### Installation System

Each topic directory can contain an `install.sh` script that handles topic-specific setup tasks. These are run by `script/install`.

## Important Files

- `zsh/zshrc.symlink` - Main shell configuration that sources all `.zsh` files
- `script/bootstrap` - Primary setup script
- `bin/dot` - System maintenance and update script
- `homebrew/Brewfile` - Complete list of applications and tools to install
