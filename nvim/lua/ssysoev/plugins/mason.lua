local function setup_diagnostics()
  vim.diagnostic.config({
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
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      }
    },
    virtual_text = {
      spacing = 4,
      prefix = "",
      severity = vim.diagnostic.severity.ERROR,
    },
  })
end

return {
  {
    -- in charge of managing lsp servers, linters & formatters
    "williamboman/mason.nvim",
    event = { "VeryLazy" },
    config = function()
      require("mason").setup()
      setup_diagnostics()

      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- Ensure installed (deferred to avoid blocking startup)
      vim.defer_fn(function()
        local registry = require("mason-registry")
        local packages = {
          "tsgo",
          "oxlint",
          "eslint-lsp",
          "lua-language-server",
          "json-lsp",
          "html-lsp",
          "css-lsp",
          "python-lsp-server",
          "cspell-lsp",
        }

        for _, pkg_name in ipairs(packages) do
          local ok, pkg = pcall(registry.get_package, pkg_name)
          if ok then
            if not pkg:is_installed() then
              pkg:install()
            end
          end
        end
      end, 0)

      vim.lsp.enable("tsgo")
      vim.lsp.enable("eslint")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("zls")
      vim.lsp.enable("rust_analyzer")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("html")
      vim.lsp.enable("cssls")
      vim.lsp.enable("pylsp")
      vim.lsp.enable("gopls")
      vim.lsp.enable("cspell_lsp")
      vim.lsp.enable("oxlint")
    end,
    dependencies = {
      -- easily configure language servers
      "neovim/nvim-lspconfig",

      -- plugin providing access to the SchemaStore catalog.
      "b0o/schemastore.nvim",
    },
  },
}
