local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "colorful-winsep" }, function(mods)
	local winsep = mods["colorful-winsep"]
	winsep.setup()
end)
