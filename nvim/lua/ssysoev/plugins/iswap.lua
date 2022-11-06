local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "iswap" }, function(mods)
	local iswap = mods.iswap
	iswap.setup()
end)
