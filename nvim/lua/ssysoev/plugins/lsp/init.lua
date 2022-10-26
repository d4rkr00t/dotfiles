local boostrap = require("ssysoev.plugins.lsp.bootstrap")
local safe_require = require("ssysoev.utils.safe-require")

-- enable keybindings for attached lsp servers
local on_attach = function(client, buffer)
	local keymap = vim.keymap

	-- keybind options
	local opts = { noremap = true, silent = true, buffer = buffer }

	-- set keybinds
	keymap.set("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- go to declaration
	keymap.set("n", "gpd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	-- keymap.set("n", "<leader>D", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
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
						on_attach = on_attach,
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

	prettier = {
		type = "formatter",
		setup_formatter = function(null_ls)
			return null_ls.builtins.formatting.prettier.with({
				prettier = {
					extra_filetypes = { "map" },
				},
			})
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
}

bootstrap(config)
