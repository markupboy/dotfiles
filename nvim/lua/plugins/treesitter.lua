return {
  -- Treesitter for syntax highlighting and more
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- List of parsers to install
        ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "bash", "json", "markdown" },

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

        -- Text objects
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },
}