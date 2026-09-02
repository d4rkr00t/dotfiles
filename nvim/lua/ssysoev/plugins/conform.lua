return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      local conform = require("conform")
      local util = require("conform.util")

      local prettier_fallback = util.from_node_modules("prettier")
      local function prettier_bin(self, ctx)
        local found = vim.fs.find("node_modules/prettier/bin/prettier.cjs",
          { upward = true, path = ctx.dirname, limit = 10 })
        return found[1] or prettier_fallback(self, ctx)
      end

      conform.setup({
        log_level = vim.log.levels.WARN,
        format_on_save = function()
          -- toggled from keymaps.lua ("Toggle format on save")
          if vim.g.format_on_save == false then
            return
          end
          return { timeout_ms = 5000, lsp_format = "fallback" }
        end,
        formatters_by_ft = {
          javascript = { "oxfmt", "prettier", stop_after_first = true },
          javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
          typescript = { "oxfmt", "prettier", stop_after_first = true },
          typescriptreact = { "oxfmt", "prettier", stop_after_first = true },
          json = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          bzl = { "buildifier" },

          lua = { "stylua" },

          rust = { "rustfmt" },
        },
        formatters = {
          prettier = {
            command = prettier_bin
          }
        }
      })
    end,
  },

}
