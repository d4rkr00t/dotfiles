local safe_require = require("ssysoev.utils.safe-require")

local function setup_null_ls()
	safe_require({ "null-ls" }, function(mods)
		local null_ls = mods["null-ls"]

		-- to setup format on save
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- configure null_ls
		null_ls.setup({
			-- debug = true,
			-- configure format on save
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								filter = function(local_client)
									-- print(local_client.name)
									return local_client.name == "null-ls"
								end,
							})
						end,
					})
				end
			end,
		})
	end)
end

return setup_null_ls
