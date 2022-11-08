local keymap = vim.keymap

-- leader
vim.g.mapleader = ","

-- general keymaps
keymap.set("n", "<CR>", ":nohl<CR>") -- remove search highlight on enter
keymap.set("n", "x", '"_x') -- in normal mode pressing x doesn't yank the char
keymap.set("n", "Q", "<nop>") -- disable ex mode
-- keymap.set("n", "q", "<nop>") -- disable recording macros
keymap.set("n", "gx", [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]]) -- open link under cursor

-- replace a word under cursor [repetable]
keymap.set("n", "<leader>cw", "<cmd>let @/='\\<'.expand('<cword>').'\\>'<cr>\"_ciw")

-- remap W -> w
vim.api.nvim_create_user_command("W", function()
	vim.cmd("w")
end, { nargs = 0 })

-- nvim-window
keymap.set("n", "<leader>w", ":lua require('nvim-window').pick()<CR>") -- same as Control+W

-- split windows
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal size
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- nvim tree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>")
keymap.set("n", "<leader>fp", "<cmd>Telescope oldfiles cwd_only=true<CR>")
keymap.set("n", "<leader>fs", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
keymap.set("n", "<leader><leader>f", "<cmd>Telescope buffers only_cwd=true<CR>")
keymap.set("n", "<leader>fo", "<cmd>Telescope lsp_document_symbols<CR>")
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>")
-- keymap.set("n", "<leader>ft", "<cmd>Telescope treesitter<CR>")

-- gitlinker
keymap.set("n", "<leader>gl", '<cmd>lua require"gitlinker".get_buf_range_url("n")<CR>', { silent = true })
keymap.set("v", "<leader>gl", '<cmd>lua require"gitlinker".get_buf_range_url("v")<CR>', { silent = true })

-- null-ls
keymap.set("n", "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<CR>")

-- trouble
keymap.set("n", "<leader>xx", "<cmd>Trouble document_diagnostics<CR>")

-- symbols outline
keymap.set("n", "<leader>so", "<cmd>SymbolsOutline<CR>")
