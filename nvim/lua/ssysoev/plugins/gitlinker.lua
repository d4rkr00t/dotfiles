local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "gitlinker" }, function(mods)
	local gitlinker = mods["gitlinker"]
	gitlinker.setup()
end)
