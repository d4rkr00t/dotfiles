local M = {}

local stats = require("ssysoev.custom.commander.stats")
local ui = require("ssysoev.custom.commander.ui")

local registry = {}

-- Function that registers a list of keymaps
-- @param desc string
-- @param cmd string
-- @param keymaps table
local function register_keymaps(desc, cmd, keymaps)
  local keymap = vim.keymap

  for _, value in ipairs(keymaps) do
    local mode = value[1]
    local lhs = value[2]
    local opts = value[3]
    if opts == nil then
      opts = {}
    end

    local id = mode .. "|" .. lhs
    local rhs, extra

    if type(cmd) == "function" then
      rhs = function()
        stats.hit(id)
        cmd()
      end
      extra = { desc = desc }
    else
      -- count the press, then hand the original rhs back to nvim untouched
      rhs = function()
        stats.hit(id)
        return cmd
      end
      extra = { desc = desc, expr = true, replace_keycodes = true }
    end

    keymap.set(mode, lhs, rhs, vim.tbl_deep_extend("force", opts, extra))
  end
end

-- Function to convert keymaps to a displayable string
local function display_keymaps(keymaps)
  local result = ""

  for _, value in ipairs(keymaps) do
    result = result .. " " .. value[1] .. "|" .. value[2] .. " "
  end

  return result
end

-- Register a list of commands
-- @param commands table
M.add = function(commands)
  for _, value in ipairs(commands) do
    if value.keys then
      if type(value.keys[1]) ~= "table" then
        value.keys = { value.keys }
      end
      register_keymaps(value.desc, value.cmd, value.keys)
    end
    table.insert(registry, value)
  end
end

-- Open a command picker, uses vim.ui.select
M.picker = function()
  vim.ui.select(registry, {
    prompt = "Command palette",
    format_item = function(item)
      if item.keys then
        return item.desc .. display_keymaps(item.keys)
      end

      return item.desc
    end,
  }, function(item)
    if item == nil then
      return
    end

    stats.hit("palette|" .. item.desc)

    if type(item.cmd) == "function" then
      item.cmd()
    else
      local cmd = vim.api.nvim_replace_termcodes(item.cmd, true, false, true)
      vim.api.nvim_feedkeys(cmd, "t", true)
    end
  end)
end

-- Open the usage dashboard
M.stats = function()
  ui.open(registry)
end

vim.api.nvim_create_autocmd("VimLeave", {
  group = vim.api.nvim_create_augroup("commander_stats", { clear = true }),
  callback = function()
    stats.flush(registry)
  end,
})

vim.api.nvim_create_user_command("CommanderStats", function()
  M.stats()
end, { nargs = 0 })

vim.api.nvim_create_user_command("CommanderStatsPrune", function()
  local dropped = stats.prune(registry)
  vim.notify("Commander: pruned " .. dropped .. " stale stats entries")
end, { nargs = 0 })

return M
