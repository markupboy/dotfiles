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
vim.opt.linebreak = true

-- file handling
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.fn.mkdir(vim.fn.stdpath("data") .. "/undodir", "p")
vim.opt.undofile = true

-- searching
vim.opt.hlsearch = true
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
vim.opt.autoread = true
vim.opt.showmatch = true
vim.opt.showbreak = "↪"
vim.opt.list = true
vim.opt.listchars = { tab = "› ", eol = "¬", trail = "⋅" }
vim.opt.fillchars:append({ eob = " " })

-- misc
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.opt.laststatus = 3

-- command-line completion
vim.opt.wildmode = "list:longest"
vim.opt.wildignore:append({ ".git", ".hg", ".svn", "*.pyc" })

-- session behavior (used by :mksession)
vim.opt.sessionoptions = "curdir,folds,help,options,tabpages,winsize"

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- insert mode: exit to normal mode without reaching for Esc
local insertEscapeChords = { "jj", "jk", "Jj", "JJ", "jK", "Jk", "JK" }
for _, chord in ipairs(insertEscapeChords) do
  vim.keymap.set("i", chord, "<Esc>")
end

-- move by display line, except with a count, so 5j matches the relnumber gutter
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- cd to the directory containing the current buffer's file
vim.keymap.set("n", "<leader>cd", "<cmd>cd %:h<CR>", { desc = "cd to buffer's directory" })
vim.keymap.set("n", "<leader>lcd", "<cmd>lcd %:h<CR>", { desc = "lcd to buffer's directory" })

-- clear search highlight
vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- write file as root when we don't have permission to save it
vim.cmd([[cnoreabbrev w!! w !sudo tee > /dev/null %]])

-- expand to the directory of the current file in command mode
vim.keymap.set("c", "%%", "<C-R>=expand('%:h').'/'<CR>")

-- buffer management
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })

-- tab management
vim.keymap.set("n", "<C-t>", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<C-c>", "<cmd>tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })

-- terminal
vim.keymap.set("n", "<leader>ot", "<cmd>terminal<CR>", { desc = "Open terminal" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
for _, chord in ipairs(insertEscapeChords) do
  vim.keymap.set("t", chord, [[<C-\><C-n>]])
end

-- SynStack: show the syntax highlight group stack under the cursor
local function synStack()
  if vim.fn.exists("*synstack") == 0 then
    return
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local groupNames = vim.tbl_map(function(syntaxId)
    return vim.fn.synIDattr(syntaxId, "name")
  end, vim.fn.synstack(line, col + 1))
  print(vim.inspect(groupNames))
end
vim.keymap.set("n", "<leader>sp", synStack, { desc = "Show syntax highlight stack" })

-- trim trailing whitespace on save, preserving cursor position and scroll view
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local savedView = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(savedView)
  end,
})

-- don't fold anything by default
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  command = "setlocal foldlevel=999999",
})

-- lazy (plugin manager)
require("config.lazy")
