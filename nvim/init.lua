-- verbose mode for logging [custom]
vim.g.VERBOSE_LOG = true
--

-- leader
vim.g.mapleader = ","
--

-- colorscheme
vim.g.THEME = "carbonfox"
--

require("ssysoev.lazy")
require("lazy").setup("ssysoev.plugins-setup")

require("ssysoev.plugins.treesitter")
require("ssysoev.core.plugins.telescope-null-ls-toggle")

require("ssysoev.core.colorscheme")
require("ssysoev.core.options")
require("ssysoev.core.keymaps")
require("ssysoev.core.filetype")
require("ssysoev.core.autocommands")
