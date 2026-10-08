vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.commentstring = "# %s"

-- tilt's LSP has no formatter; buildifier is the Starlark one
if vim.fn.executable("buildifier") == 1 then
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local res = vim.system({ "buildifier", "-type=default" }, { stdin = lines, text = true }):wait()
      if res.code ~= 0 then
        vim.notify(res.stderr, vim.log.levels.WARN)
        return
      end
      local formatted = vim.split(res.stdout, "\n")
      if formatted[#formatted] == "" then
        table.remove(formatted)
      end
      if not vim.deep_equal(formatted, lines) then
        local view = vim.fn.winsaveview()
        vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted)
        vim.fn.winrestview(view)
      end
    end,
  })
end
