local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "luasnip" }, function(mods)
	local luasnip = mods.luasnip
	luasnip.setup({
		region_check_events = "CursorHold,InsertLeave",
		delete_check_events = "TextChanged,InsertEnter",
	})

	local vscode_snippets = "~/Dropbox/Apps/vscode/snippets"
	pcall(require("luasnip.loaders.from_vscode").lazy_load, { paths = { vscode_snippets } })
end)
