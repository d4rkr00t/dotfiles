local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

---Highlight yanked text
au("TextYankPost", {
  group = ag("yank_highlight", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 80 })
  end,
})

-- Fix the issue with v:oldfiles not containing some recently opened buffers
local function add_buffer_to_oldfiles()
  local bufname = vim.fn.bufname("%")
  if bufname ~= "" and not vim.tbl_contains(vim.v.oldfiles, bufname) then
    table.insert(vim.v.oldfiles, bufname)
  end
end
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = add_buffer_to_oldfiles,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

-- show cursorline only in active window disable
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = "active_cursorline",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
