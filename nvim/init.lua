-- verbose mode for logging [custom]
vim.g.VERBOSE_LOG = false
--

-- leader
vim.g.mapleader = ","
--

-- colorscheme
-- vim.g.THEME = "tokyonight"
-- vim.g.THEME = "catppuccin"
vim.g.THEME = "rose-pine"
-- vim.g.THEME = "mellow"
--

require("ssysoev.lazy")
require("lazy").setup("ssysoev.plugins-setup", {
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
})

require("ssysoev.plugins.treesitter")

require("ssysoev.core.options")
require("ssysoev.core.keymaps")
require("ssysoev.core.filetype")
require("ssysoev.core.autocommands")
require("ssysoev.core.commands")
