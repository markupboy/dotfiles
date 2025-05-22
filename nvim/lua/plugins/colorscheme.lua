return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd.colorscheme("onedark")

    end
  },
}
