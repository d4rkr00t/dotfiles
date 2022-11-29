local bootstrap = require("ssysoev.plugins.lsp.bootstrap")
local merge_tables = require("ssysoev.utils.merge-tables")
local safe_require = require("ssysoev.utils.safe-require")

-- enable keybindings for attached lsp servers
local on_attach = function(client, buffer)
	-- set keybinds
	safe_require({ "command_center" }, function(mods)
		local cc = mods.command_center

		-- keybind options
		local opts = { noremap = true, silent = true, buffer = buffer }

		cc.add({
			{
				desc = "Show definitions",
				cmd = "<cmd>Glance definitions<CR>",
				keys = { "n", "gd", opts },
			},

			{
				desc = "Show references",
				cmd = "<cmd>Glance references<CR>",
				keys = { "n", "gr", opts },
			},

			{
				desc = "Show implementation",
				cmd = "<cmd>Glance implementations<CR>",
			},

			{
				desc = "Show type definitions",
				cmd = "<cmd>Glance type_definitions<CR>",
			},

			{
				desc = "Go to declaration",
				cmd = "<cmd>lua vim.lsp.buf.definition()<CR>",
				keys = { "n", "gD", opts },
			},

			{
				desc = "Peek definition",
				cmd = "<cmd>Lspsaga peek_definition<CR>",
				keys = { "n", "gpd", opts },
			},

			{
				desc = "Go to implementation",
				cmd = "<cmd>lua vim.lsp.buf.implementation()<CR>",
				keys = { "n", "gi", opts },
			},

			{
				desc = "Code actions",
				cmd = "<cmd>Lspsaga code_action<CR>",
				keys = { "n", "<leader>ca", opts },
			},

			{
				desc = "Smart rename",
				cmd = "<cmd>Lspsaga rename<CR>",
				keys = { "n", "<leader>rn", opts },
			},

			{
				desc = "Show line diagnostics",
				cmd = "<cmd>Lspsaga show_line_diagnostics<CR>",
				keys = { "n", "<leader>d", opts },
			},

			{
				desc = "Jump to previous diagnostic",
				cmd = "<cmd>Lspsaga diagnostic_jump_prev<CR>",
				keys = { "n", "[d", opts },
			},

			{
				desc = "Jump to next diagnostic",
				cmd = "<cmd>Lspsaga diagnostic_jump_next<CR>",
				keys = { "n", "]d", opts },
			},

			{
				desc = "Show documentation",
				cmd = "<cmd>Lspsaga hover_doc<CR>",
				keys = { "n", "K", opts },
			},

			{
				desc = "Highlight occurences of the word under cursor",
				cmd = "<cmd>lua vim.lsp.buf.document_highlight()<CR>",
				keys = { "n", "<leader>hh", opts },
			},
		})
	end)

	vim.api.nvim_exec(
		[[
          augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
    ]],
		false
	)
end

local config = {
	tsserver = {
		type = "lsp",
		setup_lsp = function()
			safe_require({ "typescript", "cmp_nvim_lsp" }, function(mods)
				local typescript = mods.typescript
				local cmp_nvim_lsp = mods.cmp_nvim_lsp
				typescript.setup({
					server = {
						capabilities = cmp_nvim_lsp.default_capabilities(),
						on_attach = function(client, bufrn)
							safe_require({ "twoslash-queries", "command_center" }, function(mods)
								local cc = mods["command_center"]
								mods["twoslash-queries"].attach(client, bufrn)

								cc.add({
									{
										desc = "Inspect with TwoslashQueries",
										cmd = "<cmd>InspectTwoslashQueries<CR>",
										keys = { "n", "<leader>ii", { noremap = true, silent = true, buffer = buffer } },
									},
								})
							end)
							on_attach(client, bufrn)
						end,
					},
				})
			end)
		end,
	},

	html = {
		type = "lsp",
		setup_lsp = function(lspconfig, defaults)
			lspconfig["html"].setup(merge_tables(defaults, {
				on_attach = on_attach,
			}))
		end,
	},

	cssls = {
		type = "lsp",
		setup_lsp = function(lspconfig, defaults)
			lspconfig["cssls"].setup(merge_tables(defaults, {
				on_attach = on_attach,
			}))
		end,
	},

	sumneko_lua = {
		type = "lsp",
		setup_lsp = function(lspconfig, defaults)
			lspconfig["sumneko_lua"].setup(merge_tables(defaults, {
				on_attach = on_attach,
				settings = { -- custom settings for lua
					Lua = {
						-- make the language server recognize "vim" global
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							-- make language server aware of runtime files
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			}))
		end,
	},

	prettierd = {
		type = "formatter",
		setup_formatter = function(null_ls)
			return null_ls.builtins.formatting.prettierd.with({
				prettierd = {
					extra_filetypes = { "map" },
				},
			})
		end,
	},

	["pylsp"] = {
		type = "lsp",
		setup_lsp = function(lspconfig, defaults)
			lspconfig["pylsp"].setup(merge_tables(defaults, {
				on_attach = on_attach,
			}))
		end,
	},

	["rust_analyzer"] = {
		type = "lsp",
		setup_lsp = function(lspconfig, defaults)
			lspconfig["rust_analyzer"].setup(merge_tables(defaults, {
				on_attach = on_attach,
			}))
		end,
	},

	["rustfmt"] = {
		type = "formatter",
		setup_formatter = function(null_ls)
			return null_ls.builtins.formatting.rustfmt
		end,
	},

	gopls = {
		type = "lsp",
		setup_lsp = function(lspconfig, defaults)
			lspconfig["gopls"].setup(merge_tables(defaults, {
				on_attach = on_attach,
			}))
		end,
	},

	goimports = {
		type = "formatter",
		setup_formatter = function(null_ls)
			return null_ls.builtins.formatting.goimports
		end,
	},

	gofmt = {
		type = "formatters",
		setup_formatter = function(null_ls)
			return null_ls.builtins.formatting.gofmt
		end,
	},

	stylua = {
		type = "formatter",
		setup_formatter = function(null_ls)
			return null_ls.builtins.formatting.stylua
		end,
	},

	eslint_d = {
		type = "formatter",
		setup_formatter = function(null_ls)
			return null_ls.builtins.diagnostics.eslint_d
		end,
	},

	gitsigns = {
		type = "formatter",
		setup_formatter = function(null_ls)
			return null_ls.builtins.code_actions.gitsigns
		end,
	},
}

bootstrap(config)

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
