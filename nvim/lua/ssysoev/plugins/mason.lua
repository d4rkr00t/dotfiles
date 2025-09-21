return {
  {
    -- in charge of managing lsp servers, linters & formatters
    "williamboman/mason.nvim",
    commit = "fc98833b6da5de5a9c5b1446ac541577059555be",
    event = { "VeryLazy" },
    config = function()
      require("ssysoev.lsp.init")
    end,
    dependencies = {
      -- bridges gap b/w mason & lspconfig
      {
        "williamboman/mason-lspconfig.nvim",
        commit = "1a31f824b9cd5bc6f342fc29e9a53b60d74af245",
      },

      -- easily configure language servers
      "neovim/nvim-lspconfig",

      -- additional functionality for typescript server (e.g. rename file & update imports)
      {
        "pmizio/typescript-tools.nvim",
        -- cond = false,
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        config = function() end,
      },

      -- plugin providing access to the SchemaStore catalog.
      "b0o/schemastore.nvim",
    },
  },
}
