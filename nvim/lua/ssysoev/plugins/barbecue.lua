local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "barbecue" }, function(mods)
	local barbecue = mods.barbecue
	barbecue.setup()
end)
