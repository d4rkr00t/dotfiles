local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "todo-comments" }, function(mods)
	local todo = mods["todo-comments"]
	todo.setup({
		signs = false,
	})
end)
