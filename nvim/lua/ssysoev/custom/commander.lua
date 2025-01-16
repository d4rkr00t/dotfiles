local M = {}

local registry = {}

-- Function that registers a list of keymaps
-- @param desc string
-- @param cmd string
-- @param keymaps table
local function register_keymaps(desc, cmd, keymaps)
  local keymap = vim.keymap

  for _, value in pairs(keymaps) do
    local opts = value[3]
    if opts == nil then
      opts = {}
    end
    keymap.set(value[1], value[2], cmd, vim.tbl_deep_extend("force", opts, { desc = desc }))
  end
end

-- Function to convert keymaps to a displayable string
local function display_keymaps(keymaps)
  local result = ""

  for _, value in pairs(keymaps) do
    result = result .. " " .. value[1] .. "|" .. value[2] .. " "
  end

  return result
end

-- Register a list of commands
-- @param commands table
M.add = function(commands)
  for _, value in pairs(commands) do
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

    if type(item.cmd) == "function" then
      item.cmd()
    else
      local cmd = vim.api.nvim_replace_termcodes(item.cmd, true, false, true)
      vim.api.nvim_feedkeys(cmd, "t", true)
    end
  end)
end

return M
