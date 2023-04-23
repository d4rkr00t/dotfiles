-- verbose mode for logging [custom]
vim.g.VERBOSE_LOG = true
--

-- leader
vim.g.mapleader = ","
--

-- colorscheme
vim.g.THEME = "tokyonight"
-- vim.g.THEME = "carbonfox"
-- vim.g.THEME = "catppuccin"
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
require("ssysoev.core.plugins.telescope-null-ls-toggle")

require("ssysoev.core.colorscheme")
require("ssysoev.core.options")
require("ssysoev.core.keymaps")
require("ssysoev.core.filetype")
require("ssysoev.core.autocommands")
require("ssysoev.core.commands")
