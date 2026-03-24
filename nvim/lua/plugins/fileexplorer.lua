return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    -- Load nvim-tree early when opening a directory so it acts as a sidebar
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function(data)
        if vim.fn.isdirectory(data.file) == 1 then
          require("nvim-tree.api").tree.open()
        end
      end,
    })
  end,
  config = function()
    require("nvim-tree").setup {
      hijack_directories = { enable = true, auto_open = true },
    }
  end,
}
