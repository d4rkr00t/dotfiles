local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "bufferline" }, function(mods)
	local bufferline = mods.bufferline

	bufferline.setup({
		options = {
			mode = "tabs",
			separator_style = "thick",
			diagnostics = "nvim_lsp",
			show_buffer_close_icons = false,
			show_close_icon = false,
			color_icons = true,
		},
	})
end)
