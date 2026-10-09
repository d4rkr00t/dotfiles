require("mini.base16").setup({
  palette = {
    base00 = "#101010",
    base01 = "#161616",
    base02 = "#242525",
    base03 = "#515051",
    base04 = "#A0A0A0",
    base05 = "#f5f5f5",
    base06 = "#f5f5f5",
    base07 = "#ffffff",
    base08 = "#FF8080",
    base09 = "#6ad0b7",
    base0A = "#f5f5f5",
    base0B = "#6ad0b7",
    base0C = "#6A9589",
    base0D = "#FFC799",
    base0E = "#A0A0A0",
    base0F = "#A0A0A0",
  },
})
vim.g.colors_name = "ember"

local peach, grey, bg, border = "#FFCFA8", "#A0A0A0", "#101010", "#282828"
local hl = {
  Identifier = { fg = peach },
  Exception = { fg = peach },
  Boolean = { fg = "#6ad0b7" },
  Operator = { fg = grey },
  ["@variable"] = { fg = peach },
  ["@property"] = { fg = peach },
  ["@variable.member"] = { fg = peach },
  ["@type.builtin"] = { fg = peach },
  ["@operator"] = { fg = grey },
  ["@keyword.import"] = { fg = grey },
  ["@tag.attribute"] = { fg = peach },
  ["@variable.parameter"] = { fg = "#f5f5f5" },
  TreesitterContext = { bg = "#1e1f1f" },
  Whitespace = { fg = "#312D2A" },
  NonText = { fg = "#312D2A" },
  SnacksPickerDir = { fg = grey },
  SnacksPickerSearch = { fg = peach, bg = "#4a3626", bold = true },
  PmenuSel = { bg = "#242525" },

  DiffAdd = { bg = "#16302a" },
  DiffDelete = { bg = "#3a1c1c" },
  DiffChange = { bg = "#1e1f1f" },
  DiffText = { bg = "#3d3020" },

  LineNr = { fg = "#515051", bg = bg },
  SignColumn = { bg = bg },
  FoldColumn = { fg = "#515051", bg = bg },
  CursorLineNr = { fg = grey, bg = bg },

  StatusLine = { fg = grey, bg = "#161616" },
  StatusLineNC = { fg = "#515051", bg = "#161616" },

  WinSeparator = { fg = border, bg = bg },
  VertSplit = { fg = border, bg = bg },
  SnacksWinSeparator = { fg = bg, bg = bg },
  FloatBorder = { fg = border, bg = bg },
  NormalFloat = { fg = "#f5f5f5", bg = bg },
  SnacksPickerBorder = { fg = border, bg = bg },
  SnacksPickerBoxBorder = { fg = border, bg = bg },
  SnacksPickerInputBorder = { fg = border, bg = bg },
  SnacksPickerListBorder = { fg = border, bg = bg },
  SnacksPickerPreviewBorder = { fg = border, bg = bg },
}
for name, val in pairs(hl) do
  vim.api.nvim_set_hl(0, name, val)
end
