local map = vim.keymap.set
local default_options = { silent = true }
local expr_options = { expr = true, silent = true }

--
-- NVim Overrides
--

---- Remap for dealing with visual line wraps

map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

---- Better indenting

map("v", "<", "<gv", default_options)
map("v", ">", ">gv", default_options)

-- Cancel search highlighting with ESC

map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_options)

-- Move selected line / block of text in visual mode

map("x", "K", ":move '<-2<CR>gv-gv", default_options)
map("x", "J", ":move '>+1<CR>gv-gv", default_options)

--
-- Plugins
--


---- Nvim Tree

map({ "n" }, "<leader>kn", "<cmd>NvimTreeFocus<cr>", default_options)

---- Telescope

map({ "n" }, "<leader>fb", "<cmd>Telescope buffers<cr>", default_options)
map({ "n" }, "<leader>ff", "<cmd>Telescope find_files<cr>", default_options)
map({ "n" }, "<leader>fg", "<cmd>Telescope live_grep<cr>", default_options)
