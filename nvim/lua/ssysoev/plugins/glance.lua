local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "glance" }, function(mods)
	local glance = mods.glance
	glance.setup({
		border = {
			enable = true,
		},
		winbar = {
			enable = false,
		},
	})
end)
