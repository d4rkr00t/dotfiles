local safe_require = require("ssysoev.utils.safe-require")

local M = {}

local function open_live_grep(path)
	safe_require({ "telescope.builtin" }, function(mods)
		local builtins = mods["telescope.builtin"]
		builtins.live_grep(require("telescope.themes").get_ivy({ search_dirs = { path } }))
	end)
end

function M.grep_at_current_tree_node()
	safe_require({ "nvim-tree.lib" }, function(mods)
		local nvimtree = mods["nvim-tree.lib"]

		local node = nvimtree.get_node_at_cursor()
		if not node then
			return
		end

		if node.type == "directory" then
			open_live_grep(node.absolute_path)
		else
			open_live_grep(node.parent.absolute_path)
		end
	end)
end

return M
