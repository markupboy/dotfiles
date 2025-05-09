return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd.colorscheme("onedark")

      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
  },
}