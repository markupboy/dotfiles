# Neovim Cheat Sheet

Your leader key is **Space**.

## Modes

| Key       | Action                                |
|-----------|---------------------------------------|
| `i`       | Enter Insert mode (type text)         |
| `a`       | Insert after cursor                   |
| `A`       | Insert at end of line                 |
| `o`       | New line below and enter Insert mode  |
| `O`       | New line above and enter Insert mode  |
| `v`       | Enter Visual mode (select text)       |
| `V`       | Visual Line mode (select whole lines) |
| `Esc`     | Back to Normal mode                   |

## Moving Around

| Key         | Action                              |
|-------------|-------------------------------------|
| `h j k l`  | Left, Down, Up, Right               |
| `w`         | Jump forward one word               |
| `b`         | Jump backward one word              |
| `e`         | Jump to end of word                 |
| `0`         | Go to beginning of line             |
| `$`         | Go to end of line                   |
| `gg`        | Go to top of file                   |
| `G`         | Go to bottom of file               |
| `Ctrl+d`   | Scroll down half page               |
| `Ctrl+u`   | Scroll up half page                 |
| `{`         | Jump to previous blank line         |
| `}`         | Jump to next blank line             |
| `%`         | Jump to matching bracket            |

## Editing

| Key         | Action                              |
|-------------|-------------------------------------|
| `x`         | Delete character under cursor       |
| `dd`        | Delete (cut) entire line            |
| `dw`        | Delete word from cursor             |
| `D`         | Delete to end of line               |
| `yy`        | Copy (yank) entire line             |
| `yw`        | Copy word                           |
| `p`         | Paste after cursor                  |
| `P`         | Paste before cursor                 |
| `u`         | Undo                                |
| `Ctrl+r`   | Redo                                |
| `ciw`       | Change inner word (delete + insert) |
| `ci"`       | Change inside quotes                |
| `di(`       | Delete inside parentheses           |
| `.`         | Repeat last change                  |
| `>>`        | Indent line                         |
| `<<`        | Unindent line                       |
| `~`         | Toggle case of character            |
| `gcc`       | Toggle comment on this line         |
| `gc`        | Toggle comment (operator, e.g. `gcap`, or over a visual selection) |

## Search

| Key         | Action                              |
|-------------|-------------------------------------|
| `/text`     | Search forward for "text"           |
| `?text`     | Search backward for "text"          |
| `n`         | Next search result                  |
| `N`         | Previous search result              |
| `*`         | Search for word under cursor        |
| `<leader>/` | Clear the search highlight          |

## Files & Buffers

| Key              | Action                           |
|------------------|----------------------------------|
| `:w`             | Save file                        |
| `:q`             | Quit                             |
| `:wq` or `ZZ`   | Save and quit                    |
| `:q!`            | Quit without saving              |
| `:e filename`    | Open a file                      |
| `:bn`            | Next buffer                      |
| `:bp`            | Previous buffer                  |
| `:bd`            | Close buffer                     |

## Splits

| Key              | Action                           |
|------------------|----------------------------------|
| `:split`         | Horizontal split                 |
| `:vsplit`        | Vertical split                   |
| `Ctrl+w h/j/k/l`| Move between splits              |
| `Ctrl+h/j/k/l`  | Move between splits (no `Ctrl+w`)|
| `Ctrl+w q`       | Close split                      |

---

## Your Custom Keybindings

### Core (init.lua)

Set directly in `init.lua`, so these work even with every plugin disabled.

**Leaving insert and terminal mode**

| Key                                | Action                                   |
|------------------------------------|------------------------------------------|
| `jj` `jk` `jK` `Jj` `JJ` `Jk` `JK` | Escape to Normal mode — any of the seven |
| `Esc`                              | Leave terminal mode (in `:terminal`)     |

All seven chords leave terminal mode too, so the habit works in both places.

**Windows and tabs**

| Key              | Action                                   |
|------------------|------------------------------------------|
| `Ctrl+h/j/k/l`   | Move between splits, no `Ctrl+w` prefix  |
| `Ctrl+t`         | New tab                                  |
| `Ctrl+c`         | Close tab                                |
| `[ t`            | Previous tab                             |
| `] t`            | Next tab                                 |

**Buffers, files and directories**

| Key              | Action                                   |
|------------------|------------------------------------------|
| `Space b d`      | Delete the current buffer                |
| `Space o t`      | Open a terminal                          |
| `Space c d`      | `cd` to the current file's directory     |
| `Space l c d`    | `lcd` to it — this window only           |

**Command line**

| Key              | Action                                   |
|------------------|------------------------------------------|
| `%%`             | Expands to the current file's directory  |
| `w!!`            | Re-save the open file through `sudo`     |

**Movement and inspection**

| Key              | Action                                   |
|------------------|------------------------------------------|
| `j` / `k`        | Move by display line (`gj`/`gk`)         |
| `Space /`        | Clear search highlight                   |
| `Space s p`      | Print the syntax groups under the cursor |

`j`/`k` move by display line, so on a wrapped line `5j` travels five screen rows
while the relative-number gutter counts five real lines. They disagree only where
a line wraps.

### File Explorer (nvim-tree)

| Key              | Action                           |
|------------------|----------------------------------|
| `Space e`        | Focus file explorer (opens it)   |
| `Space E`        | Toggle file explorer sidebar     |

In the file explorer: `a` to create, `d` to delete, `r` to rename, `Enter` to open.

### Telescope (Fuzzy Finder)

| Key              | Action                           |
|------------------|----------------------------------|
| `Space f f`      | Find files                       |
| `Space f g`      | Live grep (search file contents) |
| `Space f b`      | List open buffers                |
| `Space f h`      | Find files (including hidden)    |
| `Space f w`      | Grep for word under cursor       |
| `Space f W`      | Grep for WORD under cursor       |
| `Space f G`      | Find git-tracked files           |

In Telescope: type to filter, `Enter` to open, `Esc` to close.

### Which-Key (Keybinding Help)

Press `Space` and wait — a popup shows all available keybindings, grouped by prefix:

| Prefix           | Group                                    |
|------------------|------------------------------------------|
| `Space f`        | find (telescope)                         |
| `Space h`        | hunks (git)                              |
| `Space c`        | code                                     |
| `Space r`        | rename                                   |
| `Space w`        | workspace                                |
| `Space d`        | diagnostics / document                   |

### Git Signs

Git change indicators appear in the sign column (left gutter) for tracked files.

| Key              | Action                                   |
|------------------|------------------------------------------|
| `] c`            | Next changed hunk                        |
| `[ c`            | Previous changed hunk                    |
| `Space h s`      | Stage hunk (works on visual range too)   |
| `Space h r`      | Reset hunk (works on visual range too)   |
| `Space h S`      | Stage entire buffer                      |
| `Space h R`      | Reset entire buffer                      |
| `Space h p`      | Preview hunk in a floating window        |
| `Space h b`      | Blame current line (full)                |
| `Space h d`      | Diff current file against index          |
| `Space h D`      | Diff current file against last commit    |
| `Space h t`      | Toggle inline blame for current line     |
| `i h`            | Text object: "inside hunk" (e.g. `d i h`)|

### LSP (active when a language server attaches)

| Key              | Action                                   |
|------------------|------------------------------------------|
| `K`              | Hover documentation                      |
| `g d`            | Go to definition                         |
| `g D`            | Go to declaration                        |
| `g r`            | References (Telescope)                   |
| `g I`            | Go to implementation                     |
| `g y`            | Go to type definition                    |
| `Space r n`      | Rename symbol                            |
| `Space c a`      | Code action                              |
| `Space d`        | Buffer diagnostics (Telescope)           |
| `Space d s`      | Document symbols (Telescope)             |
| `Space w s`      | Workspace symbols (Telescope)            |

### Auto Features (just work)

- **Autopairs** - Typing `(`, `[`, `{`, or `"` auto-closes them
- **Autotag** - In HTML/JSX, closing tags are auto-inserted and renamed
- **Treesitter** - Syntax highlighting for most languages
- **Trailing whitespace** - Stripped on every save; cursor and scroll position are kept
- **Folds** - Every buffer opens fully unfolded
- **Undo** - History is written to disk and survives restarts
- **Autoread** - Files edited outside nvim are picked up automatically

---

## Your Settings at a Glance

| Setting            | Value                            |
|--------------------|----------------------------------|
| Leader key         | Space                            |
| Tab width          | 2 spaces                         |
| Line numbers       | Relative (with current line #)   |
| Search highlight   | On (`<leader>/` to clear)        |
| Undo history       | Persistent (survives restarts)   |
| Colorcolumn        | 80 characters                    |
| Scroll padding     | 8 lines from edge                |
| Clipboard          | Shared with the system           |
| Wrapping           | On, at word boundaries, `↪` marker |
| New splits         | Open below and to the right      |
| Whitespace         | Tabs, line ends and trailing shown |
