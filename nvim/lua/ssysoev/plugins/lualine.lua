local setup, lualine = pcall(require, "lualine")

if not setup then
  return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

lualine.setup({})
