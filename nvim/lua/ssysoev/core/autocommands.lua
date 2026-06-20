local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- Enable treesitter folding only for buffers with a treesitter parser
au("BufReadPost", {
  group = ag("treesitter_folds", { clear = true }),
  callback = function()
    if pcall(vim.treesitter.get_parser, 0) then
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    else
      vim.opt_local.foldmethod = "indent"
    end
  end,
})

---Highlight yanked text
au("TextYankPost", {
  group = ag("yank_highlight", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 80 })
  end,
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

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  -- vim.o.clipboard:append('unnamedplus')

  -- Fix "waiting for osc52 response from terminal" message
  -- https://github.com/neovim/neovim/issues/28611
  if vim.env.SSH_TTY ~= nil then
    -- Set up clipboard for ssh

    local function my_paste(_)
      return function(_)
        local content = vim.fn.getreg('"')
        return vim.split(content, '\n')
      end
    end

    vim.g.clipboard = {
      name = 'OSC 52',
      copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
      },
      paste = {
        -- No OSC52 paste action since wezterm doesn't support it
        -- Should still paste from nvim
        ['+'] = my_paste('+'),
        ['*'] = my_paste('*'),
      },
    }
  end
end)
