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
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 80 })
  end,
})

local ui_group = ag("ui_tweaks", { clear = true })

-- open help in vertical split
au("FileType", {
  group = ui_group,
  pattern = "help",
  command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
au("VimResized", {
  group = ui_group,
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

-- Highlight #tags in markdown. Matches are window-local, so keep them in sync
-- with whatever buffer a window shows instead of adding one per buffer in
-- ftplugin (which stacked duplicates and leaked into other buffers).
local function markdown_tag_match(win)
  for _, m in ipairs(vim.fn.getmatches(win)) do
    if m.group == "MarkdownTag" then
      return m.id
    end
  end
end

au({ "BufEnter", "WinEnter" }, {
  group = ag("markdown_tags", { clear = true }),
  callback = function(ev)
    local win = vim.api.nvim_get_current_win()
    local id = markdown_tag_match(win)
    if vim.bo[ev.buf].filetype == "markdown" then
      if not id then
        vim.api.nvim_set_hl(0, "MarkdownTag", { link = "DiagnosticError", default = true })
        vim.fn.matchadd("MarkdownTag", [[#[a-zA-Z0-9_-]\+]], 10, -1, { window = win })
      end
    elseif id then
      vim.fn.matchdelete(id, win)
    end
  end,
})

-- Set up OSC 52 clipboard when running over SSH.
--  Scheduled because it can increase startup-time.
vim.schedule(function()
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
