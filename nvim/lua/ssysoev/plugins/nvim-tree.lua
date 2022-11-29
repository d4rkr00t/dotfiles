local setup, nvimtree = pcall(require, "nvim-tree")

if not setup then
	return
end

-- configure nvim-tree
nvimtree.setup({
	-- change folder arrow icons
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
			},
		},
	},

	actions = {
		open_file = {
			resize_window = false,
			window_picker = {
				enable = true,
			},
		},
	},

	view = {
		side = "right",
		width = 40,
	},

	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},

	diagnostics = {
		enable = true,
	},
})
