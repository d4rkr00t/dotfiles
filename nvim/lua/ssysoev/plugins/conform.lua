local safe_reqiure = require("ssysoev.utils.safe-require")

safe_reqiure({ "command_center", "conform" }, function(mods)
  local cc = mods.command_center
  local conform = mods.conform

  conform.setup({
    formatters_by_ft = {
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      map = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },

      lua = { "stylua" },

      rust = { "rustfmt" },
    },

    format_on_save = {
      lsp_fallback = true,
      async = false,
    },
  })

  cc.add({
    {
      desc = "Format file",
      cmd = function()
        conform.format({
          lsp_fallback = true,
          async = false,
        })
      end,
      keys = { "n", "<leader>lf", { noremap = true, silent = true } },
    },
  })
end)
