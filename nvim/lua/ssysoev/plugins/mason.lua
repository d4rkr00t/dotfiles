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
    end,
    dependencies = {
      -- easily configure language servers
      "neovim/nvim-lspconfig",

      -- plugin providing access to the SchemaStore catalog.
      "b0o/schemastore.nvim",
    },
  },
}
