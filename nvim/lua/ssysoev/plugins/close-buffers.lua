local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "close_buffers" }, function(mods)
	local close_buffers = mods.close_buffers
	close_buffers.setup()
end)
