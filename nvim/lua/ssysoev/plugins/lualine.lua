local setup, lualine = pcall(require, "lualine")

if not setup then
  return
end

-- Color table for highlights
-- stylua: ignore
-- local colors = {
--   bg       = '#202328',
--   fg       = '#bbc2cf',
--   yellow   = '#ECBE7B',
--   cyan     = '#008080',
--   darkblue = '#081633',
--   green    = '#98be65',
--   orange   = '#FF8800',
--   violet   = '#a9a1e1',
--   magenta  = '#c678dd',
--   blue     = '#51afef',
--   red      = '#ec5f67',
-- }

local current_colors = vim.api.nvim_get_hl_by_name("Comment", true)
-- print(vim.inspect(current_colors))
-- local current_bg = string.format("%06x", 1710886)
-- local current_fg = string.format("%06x", 5660553)
local current_bg = string.format("%06x", 1710886)
local current_fg = string.format("%06x", tonumber(current_colors.foreground))

if vim.g.THEME == "noirbuddy" then
  local noirbuddy = require("noirbuddy.colors").all()
  current_bg = string.sub(noirbuddy.gray0, 2)
  current_fg = string.sub(noirbuddy.primary, 2)
end

local colors = {
  bg = current_bg,
  fg = current_fg,
  yellow = current_fg,
  cyan = current_fg,
  darkblue = current_fg,
  green = current_fg,
  orange = current_fg,
  violet = current_fg,
  magenta = current_fg,
  blue = current_fg,
  red = current_fg,
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    -- theme = "tokyonight",
    globalstatus = true,
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  extensions = {
    "nvim-tree",
    "symbols-outline",
    "trouble",
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left({
  function()
    return "▊"
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
  -- mode component
  function()
    return ""
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [""] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
})

ins_left({
  -- filesize component
  "filesize",
  cond = conditions.buffer_not_empty,
})

ins_left({
  "filename",
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = "bold" },
})

ins_left({ "location" })

ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

ins_left({
  function()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
      return ""
    else
      return "Recording @" .. recording_register
    end
  end,
  color = { fg = colors.fg, gui = "bold" },
})

ins_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
  function()
    return "%="
  end,
})

ins_left({
  -- Lsp server name .
  function()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = " LSP:",
  color = { fg = colors.fg, gui = "bold" },
})

-- Add components to right sections
ins_right({
  function()
    if require("grapple").name_or_index() == nil then
      return ""
    end
    return "[󰛢 " .. require("grapple").name_or_index() .. "]"
  end,
  color = { fg = colors.green, gui = "bold" },
})
ins_right({
  "o:encoding", -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = "bold" },
})

ins_right({
  "fileformat",
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = "bold" },
})

ins_right({
  "branch",
  icon = "",
  color = { fg = colors.violet, gui = "bold" },
})

ins_right({
  "diff",
  -- Is it me or the symbol for modified us really weird
  symbols = { added = " ", modified = "柳 ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
})

ins_right({
  function()
    return "▊"
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
})

-- Now don't forget to initialize lualine
lualine.setup(config)
