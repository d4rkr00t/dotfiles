local setup, telescope = pcall(require, "telescope")

if not setup then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				-- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
})

telescope.load_extension("fzf")
