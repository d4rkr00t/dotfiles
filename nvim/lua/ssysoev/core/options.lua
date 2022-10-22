local opt = vim.opt

-- line numbers
opt.number = true

-- tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.title = true -- show filename in the window titlebar
opt.cursorline = true -- highlight current line
opt.scrolloff = 5 -- lines above/below cusor to preferably be visible

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- make nvim use system clipboard for copying

-- split windows
opt.splitright = true
opt.splitbelow = true

-- other
opt.iskeyword:append("-") -- makes - a part of a word
