vim.api.nvim_command("augroup AutoCompileLatex")
vim.api.nvim_command("autocmd BufRead,BufNewFile *.js.map set filetype=json")
vim.api.nvim_command("autocmd BufRead,BufNewFile *.csss.map set filetype=json")
vim.api.nvim_command("augroup END")