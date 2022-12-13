local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "alpha", "alpha.themes.startify" }, function(mods)
	local alpha = mods.alpha
	local theme = mods["alpha.themes.startify"]

	theme.section.header.val = {
		"                                                    ",
		" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
		" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
		" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
		" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
		" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
		" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
		"                                                    ",
	}

	local config = {
		layout = {
			{ type = "padding", val = 1 },
			theme.section.header,
			{ type = "padding", val = 2 },
			theme.section.top_buttons,
			theme.section.mru_cwd,
			-- section.mru,
			{ type = "padding", val = 1 },
			theme.section.bottom_buttons,
			theme.section.footer,
		},
		opts = {
			margin = 3,
			redraw_on_resize = false,
			setup = function()
				vim.api.nvim_create_autocmd("DirChanged", {
					pattern = "*",
					callback = function()
						require("alpha").redraw()
					end,
				})
			end,
		},
	}

	alpha.setup(config)
end)
