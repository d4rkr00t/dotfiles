local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "conform" }, function(mods)
  local cc = require("ssysoev.custom.commander")
  local conform = mods.conform
  local should_format_on_save = true

  conform.setup({
    log_level = vim.log.levels.DEBUG,
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
      bzl = { "buildifier" },

      lua = { "stylua" },

      rust = { "rustfmt" },
    },
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      if should_format_on_save then
        -- conform.format({ bufnr = args.buf, async = true, timeout_ms = 5000, lsp_fallback = true })
        conform.format({ bufnr = args.buf, lsp_fallback = true })
      end
    end,
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
    {
      desc = "Toggle format on save",
      cmd = function()
        should_format_on_save = not should_format_on_save
      end,
    },
  })
end)
