local safe_require = require("ssysoev.utils.safe-require")

-- verbose mode for logging [custom]
vim.g.VERBOSE_LOG = false
--

-- Hide deprecated api messages
vim.deprecate = function() end

-- Experimental UI
safe_require({ "vim._core.ui2" }, function(mods)
  mods["vim._core.ui2"].enable({})
end)
-- old
safe_require({ "vim._extui" }, function(mods)
  mods["vim._extui"].enable({})
end)

-- leader
vim.g.mapleader = ","
vim.g.maplocalleader = ","
--

-- colorscheme
vim.g.THEME = "kanagawa"
-- vim.g.THEME = "xeno"
--

-- is mac
if vim.fn.has("mac") == 1 then
  vim.g.IS_MAC = true
else
  vim.g.IS_MAC = false
end

require("ssysoev.lazy-init")
require("lazy").setup({
  spec = {
    { import = "ssysoev.plugins" }
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
})

-- require("ssysoev.plugins.treesitter")

require("ssysoev.core.options")
require("ssysoev.core.keymaps")
require("ssysoev.core.filetype")
require("ssysoev.core.autocommands")
require("ssysoev.core.commands")
