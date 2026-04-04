vim.cmd("setlocal wrap")


vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("markdown_tag_highlight", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "MarkdownTag", { link = "DiagnosticError" })
    vim.fn.matchadd("MarkdownTag", [[#\([a-zA-Z0-9_-]\+\)\+]])
  end,
})
