local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "lspsaga" }, function(mods)
	local saga = mods.lspsaga

	saga.setup({
		lightbulb = {
			enable = false,
		},

		symbol_in_winbar = {
			enable = false,
		},

		diagnostic = {
			show_code_action = false,
		},
	})

	vim.diagnostic.config({
		underline = true,
		virtual_text = {
			severity = vim.diagnostic.severity.ERROR,
		},
	})
end)
