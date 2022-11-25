local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "nvim-treeclimber", "command_center" }, function(mods)
	local tc = mods["nvim-treeclimber"]
	local cc = mods["command_center"]
	local noremap = { noremap = true, silent = true }

	cc.add({
		{
			desc = "Shring selection [treesitter nodes]",
			cmd = function()
				tc.select_shrink()
			end,
			keys = {
				{ "n", "<M-j>", noremap },
				{ "x", "<M-j>", noremap },
				{ "v", "<M-j>", noremap },
			},
		},
		{
			desc = "Expand selection [treesitter nodes]",
			cmd = function()
				tc.select_expand()
			end,
			keys = {
				{ "n", "<M-k>", noremap },
				{ "x", "<M-k>", noremap },
				{ "v", "<M-k>", noremap },
			},
		},

		{
			desc = "Select top level node from current position [treesitter nodes]",
			cmd = function()
				tc.select_top_level()
			end,
			keys = {
				{ "n", "<M-g>", noremap },
				{ "x", "<M-g>", noremap },
				{ "v", "<M-g>", noremap },
			},
		},

		{
			desc = "Show controll flow [treesitter]",
			cmd = function()
				tc.show_control_flow()
			end,
		},
	})
end)
