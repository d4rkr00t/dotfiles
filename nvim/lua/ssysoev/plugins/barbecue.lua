local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "barbecue", "nvim-navic" }, function(mods)
	local barbecue = mods.barbecue
	local navic = mods["nvim-navic"]
	pcall(barbecue.setup, {
		show_modified = true,
	})

	navic.setup({
		highlight = true,
		icons = {
			File = " ",
			Module = " ",
			Namespace = " ",
			Package = " ",
			Class = " ",
			Method = " ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = " ",
			Interface = " ",
			Function = " ",
			Variable = " ",
			Constant = " ",
			String = " ",
			Number = " ",
			Boolean = " ",
			Array = " ",
			Object = " ",
			Key = " ",
			Null = " ",
			EnumMember = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
		},
	})
end)
