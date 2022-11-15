local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "barbecue", "nvim-navic" }, function(mods)
	local barbecue = mods.barbecue
	local navic = mods["nvim-navic"]
	barbecue.setup()

	navic.setup({
		highlight = true,
	})
end)
