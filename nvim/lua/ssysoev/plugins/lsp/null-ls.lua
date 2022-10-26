local safe_require = require("ssysoev.utils.safe-require")

function setup_null_ls(null_ls_setup_functions)
	safe_require({ "null-ls" }, function(mods)
		local null_ls = mods["null-ls"]

		-- to setup format on save
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- sources
		local sources = {}
		for key, value in pairs(null_ls_setup_functions) do
			table.insert(sources, value(null_ls))
		end

		-- configure null_ls
		null_ls.setup({
			-- setup formatters & linters
			sources = sources,

			-- configure format on save
			on_attach = function(current_client, bufnr)
				if current_client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								filter = function(client)
									--  only use null-ls for formatting instead of lsp server
									return client.name == "null-ls"
								end,
								bufnr = bufnr,
							})
						end,
					})
				end
			end,
		})
	end)
end

return setup_null_ls
