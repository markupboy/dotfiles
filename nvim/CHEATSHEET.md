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

## Search

| Key         | Action                              |
|-------------|-------------------------------------|
| `/text`     | Search forward for "text"           |
| `?text`     | Search backward for "text"          |
| `n`         | Next search result                  |
| `N`         | Previous search result              |
| `*`         | Search for word under cursor        |

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
| `Ctrl+w q`       | Close split                      |

---

## Your Custom Keybindings

### File Explorer (nvim-tree)

| Key              | Action                           |
|------------------|----------------------------------|
| `Space e`        | Toggle file explorer sidebar     |

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

Press `Space` and wait — a popup shows all available keybindings.

### Git Signs

Git change indicators appear in the sign column (left gutter) for tracked files.

| Key              | Action                           |
|------------------|----------------------------------|
| `] c`            | Next changed hunk                |
| `[ c`            | Previous changed hunk            |

### Auto Features (just work)

- **Autopairs** - Typing `(`, `[`, `{`, or `"` auto-closes them
- **Autotag** - In HTML/JSX, closing tags are auto-inserted and renamed
- **Treesitter** - Syntax highlighting for most languages

---

## Your Settings at a Glance

| Setting            | Value                            |
|--------------------|----------------------------------|
| Leader key         | Space                            |
| Tab width          | 2 spaces                         |
| Line numbers       | Relative (with current line #)   |
| Search highlight   | Off (clears after search)        |
| Undo history       | Persistent (survives restarts)   |
| Colorcolumn        | 80 characters                    |
| Scroll padding     | 8 lines from edge                |
