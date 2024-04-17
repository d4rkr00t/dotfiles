-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

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
  left = 16,
  right = 16,
  top = 16,
  bottom = 12,
}

config.font_size = 13
config.line_height = 1.3
config.font = wezterm.font("JetBrainsMono Nerd Font")

--
-- Key bindings
--
config.keys = {
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

--
-- Tab Title
--
local function get_current_working_folder_name(tab)
  local cwd_uri = tab.active_pane.current_working_dir.file_path

  local slash = cwd_uri:find("/")
  local cwd = cwd_uri:sub(slash)

  local HOME_DIR = os.getenv("HOME")
  if cwd == HOME_DIR then
    return "  ~"
  end

  return string.format("  %s", string.match(cwd, "[^/]+$"))
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_size)
  return wezterm.format({
    { Text = string.format(" %s", tab.tab_index + 1) },
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
