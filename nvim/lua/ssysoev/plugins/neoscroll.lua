local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "neoscroll" }, function(mods)
	local neoscroll = mods.neoscroll
	neoscroll.setup()
end)
