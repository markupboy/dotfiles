return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3", -- Use the latest stable version
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
    config = function()
      require("telescope").setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          prompt_prefix = "> ",
          selection_caret = "> ",
          entry_prefix = "  ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", results_width = 0.6 },
            vertical = { mirror = false },
          },
          file_ignore_patterns = { "node_modules", ".git" },
          path_display = { "truncate" },
          winblend = 0,
        },
      })
    end,
  },
}