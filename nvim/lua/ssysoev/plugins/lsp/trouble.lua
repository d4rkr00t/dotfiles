local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "trouble" }, function(mods)
	local trouble = mods.trouble

	trouble.setup({
		use_diagnostic_signs = false,
	})
end)
