local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "copilot" }, function(mods)
	local copilot = mods.copilot
	copilot.setup()
end)
