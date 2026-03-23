# Dotfiles Review — March 2026

## Configuration Issues

- [ ] **#10 `lsp_status` in lualine with no LSP configured** — `nvim/lua/plugins/statusline.lua:19` references `lsp_status` but no LSP plugins are installed. Shows nothing or errors.

---

## Neovim: Missing Essential Plugins

- [ ] **#15 No LSP support** — Biggest gap. Add `nvim-lspconfig` + `mason.nvim` + `mason-lspconfig.nvim` for go-to-definition, hover, rename, diagnostics, code actions. You already have mason packages at `~/.local/share/nvim/mason/packages`.

- [ ] **#16 No completion engine** — Add `nvim-cmp` + sources (`cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`). Pairs with LSP.

- [ ] **#17 No git signs** — `gitsigns.nvim` for added/modified/deleted markers in the sign column. Your colorscheme already defines GitSigns highlight groups (lines 152-157) — just unused.

- [ ] **#18 No comment toggling** — `Comment.nvim` — `gc` to toggle comments. High value, tiny config.

- [ ] **#19 No which-key** — `which-key.nvim` — shows available keybindings as you type leader sequences.

- [ ] **#20 No formatter/linter integration** — `conform.nvim` for formatting, `nvim-lint` for linting.
