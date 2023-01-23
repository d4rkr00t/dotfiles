local bootstrap = require("ssysoev.plugins.lsp.bootstrap")
local merge_tables = require("ssysoev.utils.merge-tables")
local safe_require = require("ssysoev.utils.safe-require")

-- enable keybindings for attached lsp servers
local on_attach = function(ient, buffer)
	-- set keybinds
	safe_require({ "command_center" }, function(mods)
		local cc = mods.command_center

		-- keybind options
		local opts = { noremap = true, silent = true, buffer = buffer }

		cc.add({
			{
				desc = "Show definitions",
				cmd = "<cmd>Telescope lsp_definitions<CR>",
				keys = { "n", "gd", opts },
			},

			{
				desc = "Show references",
				cmd = "<cmd>Telescope lsp_references<CR>",
				keys = { "n", "gr", opts },
			},

			{
				desc = "Show implementation",
				cmd = "<cmd>Telescope lsp_implementations<CR>",
			},

			{
				desc = "Go to declaration",
				cmd = "<cmd>lua vim.lsp.buf.definition()<CR>",
				keys = { "n", "gD", opts },
			},

			{
				desc = "Go to implementation",
				cmd = "<cmd>lua vim.lsp.buf.implementation()<CR>",
				keys = { "n", "gi", opts },
			},

			{
				desc = "Code actions",
				cmd = function()
					vim.lsp.buf.code_action()
				end,
				keys = { "n", "<leader>ca", opts },
			},

			{
				desc = "Smart rename",
				cmd = vim.lsp.buf.rename,
				keys = { "n", "<leader>rn", opts },
			},

			{
				desc = "Show line diagnostics",
				cmd = function()
					local float_opts = {
						focusable = true,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always",
						prefix = " ",
						scope = "line",
					}
					vim.diagnostic.open_float(nil, float_opts)
				end,
				keys = { "n", "<leader>d", opts },
			},

			{
				desc = "Jump to previous diagnostic",
				cmd = function()
					vim.diagnostic.goto_prev()
				end,
				keys = { "n", "[d", opts },
			},

			{
				desc = "Jump to next diagnostic",
				cmd = function()
					vim.diagnostic.goto_next()
				end,
				keys = { "n", "]d", opts },
			},

			{
				desc = "Show documentation",
				cmd = function()
					vim.lsp.buf.hover()
				end,
				keys = { "n", "K", opts },
			},

			{
				desc = "Highlight occurences of the word under cursor",
				cmd = "<cmd>lua vim.lsp.buf.document_highlight()<CR>",
				keys = { "n", "<leader>hh", opts },
			},

			{
				desc = "Signature documentation",
				cmd = vim.lsp.buf.signature_help,
				keys = { "i", "<C-k>", opts },
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

local util = require("lspconfig.util")

vim.diagnostic.config({
	signs = true,
	update_in_insert = true,
	underline = true,
	float = {
		focusable = true,
		style = "full",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
	virtual_text = {
		spacing = 4,
		prefix = "",
		severity = vim.diagnostic.severity.ERROR,
	},
})

local config = {
	tsserver = {
		type = "lsp",
		setup_lsp = function()
			safe_require({ "typescript", "cmp_nvim_lsp", "null-ls" }, function(mods)
				local typescript = mods.typescript
				local cmp_nvim_lsp = mods.cmp_nvim_lsp
				local null_ls = mods["null-ls"]

				typescript.setup({
					root_dir = function(fname)
						return util.root_pattern(".git")(fname)
					end,
					server = {
						capabilities = cmp_nvim_lsp.default_capabilities(),
						on_attach = function(client, bufrn)
							safe_require({ "twoslash-queries", "command_center" }, function(nested_mods)
								local cc = nested_mods["command_center"]
								nested_mods["twoslash-queries"].attach(client, bufrn)

								cc.add({
									{
										desc = "Inspect with TwoslashQueries",
										cmd = "<cmd>InspectTwoslashQueries<CR>",
										keys = { "n", "<leader>ii", { noremap = true, silent = true, buffer = bufrn } },
									},
								})
							end)
							on_attach(client, bufrn)
						end,
					},
				})

				-- custom sources
				null_ls.register(require("typescript.extensions.null-ls.code-actions"))
			end)
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
		setup_formatter = function()
			local null_ls = require("null-ls")
			null_ls.register(null_ls.builtins.formatting.prettier.with({
				extra_filetypes = { "map", "svelte" },
			}))
		end,
	},

	jsonls = { type = "lsp" },
	html = { type = "lsp" },
	cssls = { type = "lsp" },
	pylsp = { type = "lsp" },
	rust_analyzer = { type = "lsp" },
	rustfmt = { type = "formatter" },
	gopls = { type = "lsp" },
	goimports = { type = "formatter" },
	gofmt = { type = "formatter" },
	eslint_d = { type = "formatter" },
	gitsigns = { type = "formatter" },
}

bootstrap(config, on_attach)

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
