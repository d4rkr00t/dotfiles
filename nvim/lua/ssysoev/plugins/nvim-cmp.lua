local safe_require = require("ssysoev.utils.safe-require")
safe_require(
	{ "cmp", "luasnip", "lspkind", "nvim-autopairs.completion.cmp", "luasnip/loaders/from_vscode" },
	function(mods)
		local cmp = mods.cmp
		local luasnip = mods.luasnip
		local lspkind = mods.lspkind
		-- local cmp_autopairs = mods["nvim-autopairs.completion.cmp"]
		local vscode_lazy_loader = mods["luasnip/loaders/from_vscode"]

		luasnip.setup({
			region_check_events = "CursorHold,InsertLeave",
			delete_check_events = "TextChanged,InsertEnter",
		})

		-- load vs-code like snippets from plugins (e.g. friendly-snippets)
		vscode_lazy_loader.lazy_load()
		local vscode_snippets = "~/Dropbox/Apps/vscode/snippets"
		local vscode_loader_status = pcall(vscode_lazy_loader.lazy_load, { paths = { vscode_snippets } })
		if not vscode_loader_status then
			print("Couldn't load vscode snippets")
		end

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
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "copilot" }, -- copilot data source
				{ name = "nvim_lsp" }, -- lsp data completion
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),

			experimental = {
				ghost_text = true,
			},

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
				}),
			},
		})

		-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end
)
