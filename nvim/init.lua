-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- indentation and wrapping
vim.opt.smartindent = true
vim.opt.wrap = true

-- file handling
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.fn.mkdir(vim.fn.stdpath("data") .. "/undodir", "p")
vim.opt.undofile = true

-- searching
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- UX
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.inccommand = "split"

-- misc
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- lazy (plugin manager)
require("config.lazy")
