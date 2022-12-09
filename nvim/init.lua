pcall(require, "impatient")

-- leader
vim.g.mapleader = ","
--

require("ssysoev.plugins.plugins-setup")

require("ssysoev.core.colorscheme")

require("ssysoev.plugins.comment")
require("ssysoev.plugins.lualine")
require("ssysoev.plugins.telescope")
require("ssysoev.plugins.nvim-cmp")
require("ssysoev.plugins.lsp.init")
require("ssysoev.plugins.lspkind")
require("ssysoev.plugins.autopairs")
require("ssysoev.plugins.treesitter")
require("ssysoev.plugins.treesitter-context")
require("ssysoev.plugins.gitsigns")
require("ssysoev.plugins.alpha")
require("ssysoev.plugins.gitlinker")
require("ssysoev.plugins.nvim-window")
require("ssysoev.plugins.todo-comments")
require("ssysoev.plugins.barbecue")
require("ssysoev.plugins.yanki")
require("ssysoev.plugins.luasnip")
require("ssysoev.plugins.nvim-treeclimber")
require("ssysoev.plugins.nvim-pqf")
require("ssysoev.plugins.colorizer")
require("ssysoev.plugins.close-buffers")
require("ssysoev.plugins.bufferline")
require("ssysoev.plugins.scrollbar")

require("ssysoev.core.plugins.telescope-null-ls-toggle")

require("ssysoev.core.options")
require("ssysoev.core.keymaps")
require("ssysoev.core.filetype")
require("ssysoev.core.autocommands")
