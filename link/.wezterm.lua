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
config.scrollback_lines = 1000000
config.window_close_confirmation = "NeverPrompt"

--
-- Color & Appearance
--

config.color_scheme = "tokyonight_night"
config.window_decorations = "RESIZE"

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 30

config.window_padding = {
  left = 21,
  right = 21,
  top = 16,
  bottom = 8,
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
    key = "UpArrow",
    mods = "CMD",
    action = wezterm.action.ScrollToTop,
  },
}

--
-- Tab Title
--
local function get_current_working_folder_name(tab)
  local cwd_uri = tab.active_pane.current_working_dir

  cwd_uri = cwd_uri:sub(8)

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
    { Attribute = { Intensity = "Half" } },
    { Text = string.format(" %s", tab.tab_index + 1) },
    { Text = " " },
    { Text = wezterm.truncate_right(get_current_working_folder_name(tab), max_size - 5) },
    { Text = " ▕" },
  })
end)

return config
