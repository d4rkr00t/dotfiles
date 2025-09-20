-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

config.max_fps = 120

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

--
-- Options
--
config.scrollback_lines = 10000000
config.window_close_confirmation = "NeverPrompt"

--
-- Color & Appearance
--

-- config.color_scheme = "tokyonight_night"
config.window_decorations = "RESIZE"

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 50

config.window_padding = {
  left = "0.8 cell",
  right = "0.8 cell",
  top = "0.5 cell",
  bottom = "0.2 cell",
}

config.font_size = 13
config.line_height = 1.4
-- config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font = wezterm.font_with_fallback({
  -- {
  --   family = "CommitMono Nerd Font",
  --   harfbuzz_features = { "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "calt", "dlig" },
  -- },
  {
    family = "Monaspace Neon NF",
    harfbuzz_features = { "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "calt", "dlig" },
  },
  -- { family = "JetBrainsMono Nerd Font" },
})
config.underline_position = -8
config.underline_thickness = 2

--
-- Key bindings
--
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "\\", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-",  mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentTab({ confirm = false }),
  },
  {
    key = "k",
    mods = "CMD",
    action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
  },
  {
    key = "LeftArrow",
    mods = "ALT|SHIFT",
    action = wezterm.action.MoveTabRelative(-1),
  },
  {
    key = "RightArrow",
    mods = "ALT|SHIFT",
    action = wezterm.action.MoveTabRelative(1),
  },
  {
    key = "UpArrow",
    mods = "CMD",
    action = wezterm.action.ScrollToTop,
  },
}

config.mouse_bindings = {
  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("PrimarySelection"),
  },

  -- and make CMD open hyperlinks
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CMD",
    action = act.OpenLinkAtMouseCursor,
  },

  -- Disable the 'Down' event of CMD-Click to avoid weird program behaviors
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "CMD",
    action = act.Nop,
  },

  -- Disable copy on select
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = wezterm.action.Nop,
  },
}

--
-- Tab Title
--
local function get_current_working_folder_name(tab)
  local cwd_uri = tab.active_pane.current_working_dir.file_path
  local cwd = cwd_uri:sub(1, string.len(cwd_uri) - 1)

  local HOME_DIR = os.getenv("HOME")
  if cwd == HOME_DIR then
    return "  ~"
  end

  return string.format("  %s", string.match(cwd_uri, "[^/]+$"))
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_size)
  return wezterm.format({
    { Text = string.format("  %s", tab.tab_index + 1) },
    { Text = " " },
    { Text = get_current_working_folder_name(tab) },
    { Text = " ▕" },
  })
end)

--
-- Custom Color Scheme
--

config.colors = {
  -- The default text color
  foreground = "#cfcfcf",
  -- The default background color
  background = "#101010",

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = "#57575f",
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = "#cfcfcf",
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = "#57575f",

  -- the foreground color of selected text
  selection_fg = "#a0a0a0",
  -- the background color of selected text
  selection_bg = "#282828",

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = "#222222",

  -- The color of the split lines between panes
  split = "#363635",

  ansi = {
    "#101010",
    "#f5a191",
    "#90b99f",
    "#e6b99d",
    "#aca1cf",
    "#e29eca",
    "#ea83a5",
    "#a0a0a0",
  },
  brights = {
    "#282828",
    "#ff8080",
    "#99ffe4",
    "#ffc799",
    "#b9aeda",
    "#ecaad6",
    "#f591b2",
    "#ffffff",
  },

  tab_bar = {
    background = "#101010",
    inactive_tab_edge = "#363635",

    active_tab = {
      bg_color = "#101010",
      fg_color = "#cfcfcf",
    },

    inactive_tab = {
      bg_color = "#040204",
      fg_color = "#3D3D3C",
    },
  },
}

return config
