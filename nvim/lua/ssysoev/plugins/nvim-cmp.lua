local setup, cmp = pcall(require, "cmp")

if not setup then
	return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-\\>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),

	-- sources for autocompletion
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp data completion
		{ name = "nvim_lsp_signature_help" }, -- lsp signature data completion
		{ name = "luasnip" }, -- snippets
		{ name = "treesitter" },
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),

	experimental = {
		ghost_text = true,
	},

	-- window = {
	-- 	completion = cmp.config.window.bordered(),
	-- 	documentation = cmp.config.window.bordered(),
	-- },

	-- configure lspkind for vs-code like icons
	formatting = {
		fields = {
			cmp.ItemField.Abbr,
			cmp.ItemField.Kind,
			cmp.ItemField.Menu,
		},
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 60,
			ellipsis_char = "...",
			before = function(entry, vim_item)
				vim_item.menu = ({
					nvim_lsp = "ﲳ",
					treesitter = "",
					luasnip = "",
					path = "ﱮ",
					buffer = "﬘",
				})[entry.source.name]
				return vim_item
			end,
		}),
	},
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
