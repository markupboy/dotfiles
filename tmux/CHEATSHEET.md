# Tmux Cheat Sheet

Your prefix key is **Ctrl+b** (the default).

Tmux commands work by pressing the prefix first, releasing, then pressing the action key.

## Your Shell Aliases

| Alias | Action                              |
|-------|-------------------------------------|
| `T`   | Run startup-tmux.sh script          |
| `Ta`  | Attach to last tmux session         |
| `Tr`  | Reload tmux config                  |

---

## Sessions

A session is a workspace. You can have multiple and switch between them.

| Key / Command         | Action                            |
|-----------------------|-----------------------------------|
| `tmux`                | Start a new session               |
| `tmux new -s name`    | Start a new named session         |
| `Ta` (or `tmux attach`) | Reattach to last session        |
| `tmux attach -t name` | Attach to a named session         |
| `tmux ls`             | List all sessions                 |
| `Prefix d`            | Detach from session (leave it running) |
| `Prefix s`            | List and switch between sessions  |
| `Prefix $`            | Rename current session            |

## Windows (Tabs)

A window is like a tab inside a session.

| Key            | Action                              |
|----------------|-------------------------------------|
| `Prefix c`     | Create new window                   |
| `Prefix ,`     | Rename current window               |
| `Prefix n`     | Next window                         |
| `Prefix p`     | Previous window                     |
| `Prefix 0-9`   | Jump to window by number           |
| `Prefix w`     | List all windows (interactive)      |
| `Prefix &`     | Close current window (confirms)     |

## Panes (Splits)

A pane is a split inside a window.

### Creating Panes (your custom bindings)

| Key            | Action                              |
|----------------|-------------------------------------|
| `Prefix |`     | Split vertically (side by side)     |
| `Prefix -`     | Split horizontally (top/bottom)     |

### Navigating Panes

| Key              | Action                            |
|------------------|-----------------------------------|
| `Alt+Arrow`      | Switch panes (no prefix needed!)  |
| `Prefix q`       | Show pane numbers, press # to jump|

### Resizing Panes

| Key                    | Action                        |
|------------------------|-------------------------------|
| `Prefix Ctrl+Arrow`   | Resize pane in that direction |
| `Prefix z`             | Zoom pane (fullscreen toggle) |

### Managing Panes

| Key            | Action                              |
|----------------|-------------------------------------|
| `Prefix x`     | Close current pane (confirms)       |
| `Prefix !`     | Turn pane into its own window       |
| `Prefix Space` | Cycle through pane layouts          |

## Scrollback & Copy Mode

Mouse scrolling is enabled, but you can also use keyboard.

| Key                | Action                            |
|--------------------|-----------------------------------|
| `Prefix [`         | Enter scroll/copy mode            |
| `q`                | Exit copy mode                    |
| `Up/Down` or `j/k` | Scroll in copy mode              |
| `/text`            | Search forward in copy mode       |
| `?text`            | Search backward in copy mode      |

## Command Mode

| Key            | Action                              |
|----------------|-------------------------------------|
| `Prefix :`     | Open tmux command prompt            |

---

## Your Setup at a Glance

| Setting              | Value                            |
|----------------------|----------------------------------|
| Prefix key           | Ctrl+b (default)                 |
| Mouse support        | On (scroll, resize, click)       |
| Scrollback history   | 10,000 lines                     |
| Session restore      | Automatic (tmux-continuum)       |
| Session save/restore | Manual with tmux-resurrect       |
| Status bar left      | Session name                     |
| Status bar right     | Time and date                    |

### Tmux Resurrect / Continuum

Your sessions are automatically saved and restored across tmux restarts.

| Key                   | Action                           |
|-----------------------|----------------------------------|
| `Prefix Ctrl+s`      | Manually save session state      |
| `Prefix Ctrl+r`      | Manually restore session state   |
