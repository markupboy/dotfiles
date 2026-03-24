return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find by Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    { "<leader>fh", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Hidden Files" },
    { "<leader>fG", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
    {
      "<leader>fw",
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
      end,
      desc = "Find Word",
    },
    {
      "<leader>fW",
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
      end,
      desc = "Find WORD",
    },
  },
  opts = {},
}
