local safe_require = require("ssysoev.utils.safe-require")
local setup_null_ls = require("ssysoev.plugins.lsp.null-ls")

local function bootstrap(config)
	safe_require({ "mason", "mason-lspconfig", "mason-null-ls", "lspconfig", "cmp_nvim_lsp" }, function(mods)
		--
		--
		-- preprocess config
		--
		--
		local mason_ensure_installed = {}
		local mason_null_ls_ensure_installed = {}
		local lsp_setup_functions = {}
		local null_ls_setup_functions = {}

		for key, value in pairs(config) do
			if value.type == "lsp" then
				table.insert(mason_ensure_installed, key)
				table.insert(lsp_setup_functions, value.setup_lsp)
			elseif value.type == "formatter" then
				table.insert(mason_null_ls_ensure_installed, key)
				table.insert(null_ls_setup_functions, value.setup_formatter)
			end
		end

		--
		--
		-- setup mason
		--
		--
		local mason = mods.mason
		local mason_lspconfig = mods["mason-lspconfig"]
		local mason_null_ls = mods["mason-null-ls"]
		mason.setup()
		mason_lspconfig.setup({
			-- list of lsp servers to install
			ensure_installed = mason_ensure_installed,
		})

		mason_null_ls.setup({
			-- list of formatters & linters for mason to install
			ensure_installed = mason_null_ls_ensure_installed,
			-- auto-install configured formatters & linters (with null-ls)
			automatic_installation = true,
		})

		--
		--
		-- setup lspconfig
		--
		--
		local lspconfig = mods.lspconfig
		local cmp_nvim_lsp = mods.cmp_nvim_lsp
		local lspconfig_defaults = {
			capabilities = cmp_nvim_lsp.default_capabilities(),
		}
		for key, value in pairs(lsp_setup_functions) do
			pcall(value, lspconfig, lspconfig_defaults)
		end

		--
		--
		-- setup null-ls
		--
		--
		setup_null_ls(null_ls_setup_functions)
	end)
end

return bootstrap
