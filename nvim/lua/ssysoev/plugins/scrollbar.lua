local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "scrollbar" }, function(mods)
	local scrollbar = mods.scrollbar
	scrollbar.setup({
		handlers = {
			gitsigns = true,
		},
	})
end)
