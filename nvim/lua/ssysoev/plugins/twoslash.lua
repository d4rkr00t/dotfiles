local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "twoslash-queries" }, function(mods)
	local tsq = mods["twoslash-queries"]
	tsq.setup({
		multi_line = true,
		enabled = false,
	})
end)
