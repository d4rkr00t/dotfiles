local safe_require = require("ssysoev.utils.safe-require")

local theme = vim.g.THEME

--
--
-- nightfox - carbonfox variant
--
--
if theme == "carbonfox" then
	safe_require({ "nightfox" }, function(mods)
		local nightfox = mods.nightfox
		nightfox.setup({
			options = {
				styles = {
					comments = "italic",
					keywords = "bold",
					functions = "italic,bold",
				},
				inverse = {
					search = true,
				},
			},
		})

		pcall(vim.cmd, "colorscheme carbonfox")
	end)

--
--
-- oxocarbon
--
--
elseif theme == "oxocarbon" then
	safe_require({ "oxocarbon" }, function()
		pcall(vim.cmd, "colorscheme oxocarbon")
	end)

--
--
-- material
--
--
elseif theme == "material" then
	safe_require({ "material" }, function(mods)
		vim.g.material_style = "deep ocean"
		pcall(vim.cmd, "colorscheme material")
		local material = mods.material
		material.setup({
			styles = { -- Give comments style such as bold, italic, underline etc.
				comments = { italic = true },
				strings = {},
				keywords = { bold = true },
				functions = {},
				variables = {},
				operators = { bold = true },
				types = {},
			},

			plugins = { -- Uncomment the plugins that you use to highlight them
				-- Available plugins:
				-- "dap",
				"dashboard",
				"gitsigns",
				-- "hop",
				"indent-blankline",
				"lspsaga",
				-- "mini",
				-- "neogit",
				"nvim-cmp",
				-- "nvim-navic",
				"nvim-tree",
				"nvim-web-devicons",
				-- "sneak",
				"telescope",
				"trouble",
				-- "which-key",
			},

			-- disable = {
			-- 	colored_cursor = false, -- Disable the colored cursor
			-- 	borders = false, -- Disable borders between verticaly split windows
			-- 	background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
			-- 	term_colors = false, -- Prevent the theme from setting terminal colors
			-- 	eob_lines = false, -- Hide the end-of-buffer lines
			-- },

			high_visibility = {
				lighter = false, -- Enable higher contrast text for lighter style
				darker = false, -- Enable higher contrast text for darker style
			},

			lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

			async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

			custom_colors = nil, -- If you want to everride the default colors, set this to a function

			custom_highlights = {}, -- Overwrite highlights with your own
		})
	end)

--
--
-- catppuccin
--
--
elseif theme == "catppuccin" then
	safe_require({ "catppuccin" }, function(mods)
		local catppuccin = mods.catppuccin

		pcall(vim.cmd, "colorscheme catppuccin")

		catppuccin.setup({
			dim_inactive = {
				enabled = true,
				shade = "dark",
				percentage = 0.5,
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				symbols_outline = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
				lsp_trouble = true,
				lsp_saga = true,
				mason = true,
				navic = {
					enabled = true,
					custom_bg = "NONE",
				},
				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
		})
	end)
end
