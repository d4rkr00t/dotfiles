local safe_require = require("ssysoev.utils.safe-require")
local merge_tables = require("ssysoev.utils.merge-tables")

local function bootstrap(config, on_attach)
  safe_require({ "mason", "mason-lspconfig", "lspconfig", "cmp_nvim_lsp" }, function(mods)
    --
    --
    -- setup lspconfig
    --
    --
    local lspconfig = mods.lspconfig
    local cmp_nvim_lsp = mods.cmp_nvim_lsp
    local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

    local lspconfig_defaults = {
      capabilities = capabilities,
    }

    --
    --
    -- preprocess config
    --
    --
    local mason_ensure_installed = { "ts_ls@4.4.1" }
    local lsp_setup_functions = {}

    for key, value in pairs(config) do
      table.insert(mason_ensure_installed, key)
      if value.type == "lsp" then
        if value.setup_lsp then
          lsp_setup_functions[key] = function()
            return value.setup_lsp(lspconfig, lspconfig_defaults)
          end
        end
      end
    end

    --
    --
    -- setup mason
    --
    --
    local mason = mods.mason
    local mason_lspconfig = mods["mason-lspconfig"]
    mason.setup()
    mason_lspconfig.setup({
      -- list of lsp servers to install
      ensure_installed = mason_ensure_installed,
    })
    mason_lspconfig.setup_handlers(merge_tables({
      function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({ on_attach = on_attach, capabilities = capabilities })
      end,
    }, lsp_setup_functions))
  end)
end

return bootstrap
