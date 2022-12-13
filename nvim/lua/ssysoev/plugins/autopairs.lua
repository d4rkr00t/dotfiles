local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "nvim-autopairs" }, function(mods)
	local autopairs = mods["nvim-autopairs"]

	-- configure autopairs
	autopairs.setup({
		check_ts = true, -- enable treesitter
		disable_filetype = { "TelescopePrompt" },
		ts_config = {
			lua = { "string" }, -- don't add pairs in lua string treesitter nodes
			javascript = { "template_string" }, -- don't add pairs in javascript template_string treesitter nodes
			java = false, -- don't check treesitter on java
		},
	})
end)
