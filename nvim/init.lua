-- verbose mode for logging [custom]
vim.g.VERBOSE_LOG = false
--

-- Hide deprecated api messages
vim.deprecate = function() end

-- Experimental UI
require("vim._extui").enable({})

-- leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","
--

-- colorscheme
vim.g.THEME = "kanagawa"
--

-- is mac
if vim.fn.has("mac") == 1 then
  vim.g.IS_MAC = true
else
  vim.g.IS_MAC = false
end

require("ssysoev.lazy-init")
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
