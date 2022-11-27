local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "colorizer" }, function(mods)
	local colorizer = mods.colorizer
	colorizer.setup()
end)
