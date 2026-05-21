return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>f", group = "find" },
      { "<leader>h", group = "hunks (git)" },
      { "<leader>w", group = "workspace" },
      { "<leader>c", group = "code" },
      { "<leader>r", group = "rename" },
      { "<leader>d", group = "diagnostics/docs" },
    },
  },
}
