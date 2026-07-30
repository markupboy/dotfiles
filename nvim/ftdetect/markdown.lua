-- .md is already detected by Neovim core; add the less common aliases
vim.filetype.add({
  extension = {
    markdown = "markdown",
    mdown = "markdown",
  },
})
