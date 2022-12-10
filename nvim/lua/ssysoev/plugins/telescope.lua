local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "telescope", "telescope-live-grep-args.actions", "command_center" }, function(mods)
	local telescope = mods.telescope
	local lga_actions = mods["telescope-live-grep-args.actions"]
	local command_center = mods.command_center
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-k>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
					["<C-i>"] = lga_actions.quote_prompt(),
					["<C-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
				},
			},
			cache_picker = {
				num_pickers = 5,
			},
			dynamic_preview_title = true,
			prompt_prefix = " ?  ",
			selection_caret = "  ",
			entry_prefix = "  ",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
				},
				preview_cutoff = 120,
			},
			file_ignore_patterns = { "node_modules/", ".git/" },
			path_display = { "truncate" },
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_sorter = require("telescope.sorters").get_fzy_sorter,
		},
		extensions = {
			command_center = {
				components = {
					command_center.component.DESC,
					command_center.component.KEYS,
				},
				sort_by = {
					command_center.component.DESC,
					command_center.component.KEYS,
				},
				auto_replace_desc_with_cmd = false,
			},
		},
	})

	telescope.load_extension("fzf")
	telescope.load_extension("yank_history")
	telescope.load_extension("command_center")
end)
