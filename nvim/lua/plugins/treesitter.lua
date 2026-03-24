return {
  -- Treesitter for syntax highlighting and more
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- List of parsers to install
      ensure_installed = { "lua", "javascript", "typescript", "html", "css", "bash", "json", "markdown", "go", "rust", "ruby" },

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- Highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      -- Incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    },
  },
}
