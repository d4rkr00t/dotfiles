local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "gitsigns", "command_center" }, function(mods)
	local gitsigns = mods.gitsigns
	local cc = mods.command_center

	gitsigns.setup()

	cc.add({
		{
			desc = "Preview hunk",
			cmd = "<cmd>Gitsigns preview_hunk<cr>",
		},

		{
			desc = "Diff this",
			cmd = "<cmd>Gitsigns diffthis<cr>",
		},

		{
			desc = "Toggle current line diff",
			cmd = "<cmd>Gitsigns toggle_current_line_blame<cr>",
		},

		{
			desc = "Blame line",
			cmd = function()
				gitsigns.blame_line({ full = true })
			end,
		},
	})
end)
