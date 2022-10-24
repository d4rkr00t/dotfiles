local keymap = vim.keymap

-- leader
vim.g.mapleader = ","

-- general keymaps
keymap.set("n", "<CR>", ":nohl<CR>") -- remove search highlight on enter
keymap.set("n", "x", '"_x') -- in normal mode pressing x doesn't yank the char
keymap.set("n", "Q", "<nop>") -- disable ex mode
keymap.set("n", "q", "<nop>") -- disable recording macros

-- split windows
keymap.set("n", "<leader>w", "<C-w>") -- same as Control+W
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal size
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- nvim tree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
keymap.set("n", "<leader>fp", "<cmd>Telescope oldfiles<CR>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
keymap.set("n", "<leader>fo", "<cmd>Telescope lsp_document_symbols<CR>")
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>")
-- keymap.set("n", "<leader>ft", "<cmd>Telescope treesitter<CR>")
