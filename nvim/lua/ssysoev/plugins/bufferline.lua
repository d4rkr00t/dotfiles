local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "bufferline" }, function(mods)
	local bufferline = mods.bufferline

	bufferline.setup({
		options = {
			mode = "tabs",
			separator_style = "thick",
			diagnostics = "nvim_lsp",
			color_icons = true,
			always_show_bufferline = false,
		},
	})
end)
