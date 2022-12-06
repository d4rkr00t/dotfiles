local safe_require = require("ssysoev.utils.safe-require")
local setup, lualine = pcall(require, "lualine")

if not setup then
	return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Default colors
local colors = {
	bg = "#101019",
	fg = "#cdd6f4",
	yellow = "#f9e2af",
	cyan = "#89dceb",
	darkblue = "#45475a",
	green = "#a6e3a1",
	orange = "#fab387",
	violet = "#cba6f7",
	magenta = "#f5c2e7",
	blue = "#89b4fa",
	red = "#f38ba8",
	git = {
		added = "#a6e3a1",
		modified = "#fab387",
		removed = "#f38ba8",
	},
	diag = {
		error = "#f38ba8",
		warn = "#fab387",
		info = "#89dceb",
	},
}

local themed_colors = safe_require({ "nightfox" }, function()
	local theme_name = vim.api.nvim_command_output("colorscheme")
	local status, s = pcall(require("nightfox.spec").load, theme_name)
	if not status then
		s = require("nightfox.spec").load("nightfox")
	end
	return {
		bg = s.bg0,
		fg = s.fg1,
		yellow = s.palette.yellow.base,
		cyan = s.palette.cyan.base,
		darkblue = s.palette.blue.dim,
		green = s.palette.green.base,
		orange = s.palette.orange.base,
		pink = s.palette.pink.base,
		magenta = s.palette.magenta.base,
		blue = s.palette.blue.base,
		red = s.palette.red.base,
		git = {
			added = s.git.add,
			modified = s.git.changed,
			removed = s.git.removed,
		},
		diag = {
			error = s.diag.error,
			warn = s.diag.warn,
			info = s.diag.info,
		},
	}
end)

if themed_colors then
	colors = themed_colors
end

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
		disabled_filetypes = { "NvimTree", "alpha" },
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return "▊"
	end,
	color = { fg = colors.blue }, -- Sets highlighting of component
	padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
	-- mode component
	function()
		return ""
	end,
	color = function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			[""] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.pink,
			Rv = colors.pink,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { right = 1 },
})

ins_left({
	-- filesize component
	"filesize",
	cond = conditions.buffer_not_empty,
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.magenta, gui = "bold" },
})

ins_left({ "location" })

ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.diag.error },
		color_warn = { fg = colors.diag.warn },
		color_info = { fg = colors.diag.info },
	},
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
	function()
		return "%="
	end,
})

ins_left({
	-- Lsp server name .
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " LSP:",
	color = { fg = colors.fg, gui = "bold" },
})

-- Add components to right sections
ins_right({
	"o:encoding", -- option component same as &encoding in viml
	cond = conditions.hide_in_width,
	color = { fg = colors.green, gui = "bold" },
})

ins_right({
	"filetype",
	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	color = { fg = colors.green, gui = "bold" },
})

ins_right({
	"branch",
	icon = "",
	color = { fg = colors.pink, gui = "bold" },
})

ins_right({
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = "柳", removed = " " },
	diff_color = {
		added = { fg = colors.git.add },
		modified = { fg = colors.git.changed },
		removed = { fg = colors.git.removed },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		return "▊"
	end,
	color = { fg = colors.blue },
	padding = { left = 1 },
})

-- Now don't forget to initialize lualine
lualine.setup(config)
