local opt = vim.opt

opt.shortmess:append("I")
opt.shortmess:append("C")

-- Decrease update time
opt.updatetime = 250

-- mouse
opt.mouse = "a"

-- line numbers
opt.number = true

-- tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- preview s/from/to replacements
opt.inccommand = "nosplit"

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes:1" -- always show signcolumns
opt.title = true -- show filename in the window titlebar
opt.cursorline = true -- highlight current line
opt.scrolloff = 10 -- lines above/below cusor to preferably be visible
opt.ch = 0 -- height of a command line

-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noselect"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- make nvim use system clipboard for copying

-- split windows
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

-- other
opt.iskeyword:append("-") -- makes - a part of a word
opt.joinspaces = false -- No double spaces with join
opt.autoread = true -- Deal with file loads after updating via git etc

-- folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldtext = "substitute(getline(v:foldstart),'\\t',repeat(' ',&tabstop),'g').'...'.trim(getline(v:foldend))"
opt.fillchars = "fold: "
opt.foldnestmax = 10
opt.foldminlines = 1
opt.foldlevel = 99

-- invisible characters
opt.list = true -- Show some invisible characters
opt.listchars = { tab = " ", trail = "·" }

-- undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undo"

-- vim.cmd("highlight Normal ctermbg=none guibg=none")
