local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "oh-lucy" }, function(mods)
	pcall(vim.cmd, "colorscheme oh-lucy")
end)

-- safe_require({ "catppuccin" }, function(mods)
-- 	local catppuccin = mods.catppuccin
--
-- 	pcall(vim.cmd, "colorscheme catppuccin")
--
-- 	catppuccin.setup({
-- 		dim_inactive = {
-- 			enabled = true,
-- 			shade = "dark",
-- 			percentage = 0.5,
-- 		},
-- 		integrations = {
-- 			cmp = true,
-- 			gitsigns = true,
-- 			nvimtree = true,
-- 			symbols_outline = true,
-- 			telescope = true,
-- 			treesitter = true,
-- 			treesitter_context = true,
-- 			lsp_trouble = true,
-- 			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
-- 		},
-- 	})
-- end)

-- safe_require({ "rose-pine" }, function(mods)
-- 	local rose = mods["rose-pine"]
--
-- 	pcall(vim.cmd, "colorscheme rose-pine")
--
-- 	rose.setup({
-- 		dark_variant = "moon",
-- 	})
-- end)
