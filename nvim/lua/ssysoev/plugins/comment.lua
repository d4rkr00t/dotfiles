local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "mini.comment" }, function(mods)
	local comment = mods["mini.comment"]
	comment.setup({
		hooks = {
			pre = function()
				require("ts_context_commentstring.internal").update_commentstring({})
			end,
		},
	})
end)
