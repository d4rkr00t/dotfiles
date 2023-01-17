local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "lspsaga" }, function(mods)
	local saga = mods.lspsaga

	saga.setup({
		-- keybinds for navigation in lspsaga window
		move_in_saga = { prev = "<C-k>", next = "<C-j>" },
		-- use enter to open file with finder
		finder_action_keys = {
			open = "<CR>",
		},
		-- use enter to open file with definition preview
		definition_action_keys = {
			edit = "<CR>",
		},

		code_action_lightbulb = {
			enable = false,
		},

		symbol_in_winbar = {
			enable = false,
		},
	})

	vim.diagnostic.config({
		underline = true,
		virtual_text = {
			severity = vim.diagnostic.severity.ERROR,
		},
	})
end)
