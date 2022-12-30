local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "indent_blankline" }, function(mods)
	local indent_blankline = mods.indent_blankline
	indent_blankline.setup({
		space_char_blankline = " ",
		show_current_context = true,
	})
end)
