local safe_reqiure = require("ssysoev.utils.safe-require")
local keymap = vim.keymap

-- leader
vim.g.mapleader = ","

-- general keymaps
keymap.set("n", "<CR>", ":nohl<CR>") -- remove search highlight on enter
keymap.set("n", "x", '"_x') -- in normal mode pressing x doesn't yank the char
keymap.set("n", "Q", "<nop>") -- disable ex mode

vim.cmd([[augroup quickfix_enter]])
vim.cmd([[  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>]])
vim.cmd([[augroup END]])

-- remap W -> w
vim.api.nvim_create_user_command("W", function()
	vim.cmd("w")
end, { nargs = 0 })

-- remap Q -> q
vim.api.nvim_create_user_command("Q", function()
	vim.cmd("q")
end, { nargs = 0 })

-- close all floating windows
local function close_floating()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_win_close(win, false)
		end
	end
end

safe_reqiure({ "command_center" }, function(mods)
	local cc = mods.command_center
	local noremap = { noremap = true, silent = true }

	cc.add({
		{
			desc = "Open command_center",
			cmd = "<CMD>Telescope command_center<CR>",
			keys = {
				{ "n", "<Leader>cc", noremap },
				{ "v", "<Leader>cc", noremap },

				-- If ever hesitate when using telescope start with <leader>f,
				-- also open command center
				{ "n", "<Leader>f", noremap },
				{ "v", "<Leader>f", noremap },
			},
		},

		{
			desc = "Open link under cursor",
			cmd = [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]],
			keys = { "n", "gx", noremap },
		},

		{
			desc = "Replace a word under cursor [repetable]",
			cmd = "<cmd>let @/='\\<'.expand('<cword>').'\\>'<cr>\"_ciw",
			keys = { "n", "<leader>cw", noremap },
		},

		{
			desc = "Clear buffers",
			cmd = "<cmd>silent %bd|e#<cr>",
		},

		{
			desc = "Close all floating windows",
			cmd = function()
				close_floating()
			end,
		},

		-- move lines
		{
			desc = "Move lines up",
			cmd = "<cmd>m .-2<cr>==",
			keys = { "n", "<M-UP>", noremap },
		},

		{
			desc = "Move lines up",
			cmd = "<Esc><cmd>m .-2<CR>==gi",
			keys = { "i", "<M-UP>", noremap },
			mode = cc.mode.SET,
		},

		{
			desc = "Move lines down",
			cmd = "<cmd>m .+1<CR>==",
			keys = { "n", "<M-DOWN>", noremap },
		},

		{
			desc = "Move lines down",
			cmd = "<Esc><cmd>m .+1<CR>==gi",
			keys = { "i", "<M-DOWN>", noremap },
			mode = cc.mode.SET,
		},

		-- nvim-window
		{
			desc = "Switch between splits",
			cmd = ":lua require('nvim-window').pick()<CR>",
			keys = { "n", "<leader>w", noremap },
		},

		-- split windows
		{
			desc = "Split window vertically",
			cmd = "<C-w>v",
			keys = { "n", "<leader>sv", noremap },
		},

		{
			desc = "Split window horizontally",
			cmd = "<C-w>s",
			keys = { "n", "<leader>sh", noremap },
		},

		{
			desc = "Make split windows equal size",
			cmd = "<C-w>=",
			keys = { "n", "<leader>se", noremap },
		},

		{
			desc = "Close current split window",
			cmd = ":close<CR>",
			keys = { "n", "<leader>sx", noremap },
		},

		{
			desc = "Reduce the split width",
			cmd = "<cmd>vert resize -2<CR>",
			keys = { "n", "<M-9>", noremap },
		},

		{
			desc = "Increase the split width",
			cmd = "<cmd>vert resize +2<CR>",
			keys = { "n", "<M-0>", noremap },
		},

		{
			desc = "Reduce the split height",
			cmd = "<cmd>resize -2<CR>",
			keys = { "n", "<M-(>", noremap },
		},

		{
			desc = "Increase the split height",
			cmd = "<cmd>resize +2<CR>",
			keys = { "n", "<M-)>", noremap },
		},

		-- nvim tree
		{
			desc = "Toggle NvimTree",
			cmd = ":NvimTreeToggle<CR>",
			keys = { "n", "<leader>ee", noremap },
		},

		{
			desc = "Open NvimTree and focus current file",
			cmd = ":NvimTreeFindFile<CR>",
			keys = { "n", "<leader>ef", noremap },
		},

		-- telescope
		{
			desc = "Telescope find files",
			cmd = "<cmd>Telescope find_files hidden=true<CR>",
			keys = { "n", "<leader>ff", noremap },
		},

		{
			desc = "Telescope buffers",
			cmd = "<cmd>Telescope buffers only_cwd=true<CR>",
			keys = { "n", "<leader>b", noremap },
		},

		{
			desc = "Telescope old find",
			cmd = "<cmd>Telescope oldfiles cwd_only=true<CR>",
			keys = { "n", "<leader>o", noremap },
		},

		{

			desc = "Telescope live grep",
			cmd = "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
			keys = { "n", "<leader>fs", noremap },
		},

		{
			desc = "Telescope document symbols",
			cmd = "<cmd>Telescope lsp_document_symbols<CR>",
			keys = { "n", "<leader>fo", noremap },
		},

		{
			desc = "Telescope diagnostics",
			cmd = "<cmd>Telescope diagnostics<CR>",
			keys = { "n", "<leader>fd", noremap },
		},

		{
			desc = "Telescope restore previous picker",
			cmd = "<cmd>Telescope pickers<CR>",
			keys = { "n", "<leader>fr", noremap },
		},

		{
			desc = "Telescope yank history",
			cmd = "<cmd>Telescope yank_history<CR>",
			keys = { "n", "<leader>yh", noremap },
		},

		-- gitlinker
		{
			desc = "Open in Github",
			cmd = '<cmd>lua require"gitlinker".get_buf_range_url("n")<CR>',
			keys = { "n", "<leader>gl", noremap },
		},

		{
			desc = "Open in Github",
			cmd = '<cmd>lua require"gitlinker".get_buf_range_url("v")<CR>',
			keys = { "v", "<leader>gl", noremap },
			mode = cc.mode.SET,
		},

		-- null-ls
		{
			desc = "Format with lsp client",
			cmd = ":lua vim.lsp.buf.format({ async = true })<CR>",
			keys = { "n", "<leader>lf", noremap },
		},

		-- trouble
		{
			desc = "Trouble document diagnostics",
			cmd = "<cmd>Trouble document_diagnostics<CR>",
			keys = { "n", "<leader>xx", noremap },
		},
		{
			desc = "Trouble project diagnostics",
			cmd = "<cmd>Trouble workspace_diagnostics<CR>",
		},

		-- symbols outline
		{
			desc = "Symbols outline",
			cmd = "<cmd>SymbolsOutline<CR>",
			keys = { "n", "<leader>so", noremap },
		},

		-- yanky
		{
			desc = "Yanky Cycle Forward",
			cmd = "<Plug>(YankyCycleForward)",
			keys = {
				{ "n", "<c-n>", noremap },
				{ "x", "<c-n>", noremap },
			},
		},

		{
			desc = "Yanky Cycle Backward",
			cmd = "<Plug>(YankyCycleBackward)",
			keys = {
				{ "n", "<c-p>", noremap },
				{ "x", "<c-p>", noremap },
			},
		},

		-- commenter
		{
			desc = "Toggle line comment",
			cmd = "<Plug>(comment_toggle_linewise_current)<cr>",
			keys = { "n", "gcc", noremap },
			mode = cc.mode.ADD,
		},

		{
			desc = "Toggle block comment",
			cmd = "<Plug>(comment_toggle_blockwise_visual)<cr>",
			keys = { "n", "gbc", noremap },
			mode = cc.mode.ADD,
		},

		-- iswap
		{
			desc = "Swap function arguments/parameters",
			cmd = "<cmd>ISwap<cr>",
		},

		-- todo-comments
		{
			desc = "Show todo comments in a project",
			cmd = "<cmd>TodoTelescope<cr>",
		},
	})
end)

-- yanky
keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

-- Delete a word backwards
-- keymap.set("n", "dw", 'vb"_d')

-- move lines visual mode maps
keymap.set("v", "<M-DOWN>", ":m '>+1<CR>gvgv=gv", { noremap = true, silent = true })
keymap.set("v", "<M-UP>", ":m '<-2<CR>gvgv=gv", { noremap = true, silent = true })
