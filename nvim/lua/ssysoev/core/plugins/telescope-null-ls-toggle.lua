local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "null-ls", "telescope" }, function(mods)
	local nullLs = mods["null-ls"]
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local get_souces = function()
		local sources = nullLs.get_sources()
		local result = {}
		for _, item in pairs(sources) do
			table.insert(result, item.name)
		end

		return result
	end

	-- picker function
	local sources = function(opts)
		opts = opts or {}
		pickers
			.new(opts, {
				prompt_title = "Toggle null-ls sources",
				finder = finders.new_table({
					results = get_souces(),
				}),
				sorter = conf.generic_sorter(opts),
				attach_mappings = function(prompt_bufnr, map)
					actions.select_default:replace(function()
						actions.close(prompt_bufnr)
						local selection = action_state.get_selected_entry()
						nullLs.toggle(selection[1])
					end)
					return true
				end,
			})
			:find()
	end

	vim.keymap.set("n", "<leader>nt", function()
		sources(require("telescope.themes").get_dropdown({}))
	end)
end)