local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "yanky" }, function(mods)
	local yanky = mods.yanky
	yanky.setup({
		highlight = {
			on_yank = true,
			on_put = true,
			timer = 300,
		},
	})
end)
