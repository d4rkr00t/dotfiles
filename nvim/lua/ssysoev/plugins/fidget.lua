local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "fidget" }, function(mods)
	local fidget = mods.fidget
	fidget.setup()
end)
