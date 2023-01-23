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
