local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "symbols-outline" }, function(mods)
	local symbols = mods["symbols-outline"]
	symbols.setup()
end)
