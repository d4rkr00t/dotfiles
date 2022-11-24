local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "pqf" }, function(mods)
	local pqf = mods.pqf
	pqf.setup()
end)
