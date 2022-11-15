local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "telescope", "telescope-live-grep-args.actions" }, function(mods)
	local telescope = mods.telescope
	local lga_actions = mods["telescope-live-grep-args.actions"]
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-u>"] = false, -- clear prompt
					["<C-k>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
					["<C-i>"] = lga_actions.quote_prompt(),
					["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				},
			},
			dynamic_preview_title = true,
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
			file_ignore_patterns = { "node_modules/", ".git/" },
			path_display = { "truncate" },
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		},
	})

	telescope.load_extension("fzf")
	telescope.load_extension("yank_history")
end)
