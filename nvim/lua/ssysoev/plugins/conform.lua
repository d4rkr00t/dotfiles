return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local cc = require("ssysoev.custom.commander")
      local conform = require("conform")
      local util = require("conform.util")
      local should_format_on_save = true

      local prettier_bin = util.from_node_modules("prettier")
      local maybe_prettier_bin = vim.fs.find('node_modules/prettier/bin/prettier.cjs',
        { upward = true, path = vim.api.nvim_buf_get_name(0), limit = 10 })

      if maybe_prettier_bin[1] then
        vim.fn.jobstart({ "chmod", "+x", maybe_prettier_bin[1] })
        prettier_bin = function()
          return maybe_prettier_bin[1]
        end
      end

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
        formatters = {
          prettier = {
            command = prettier_bin
          }
        }
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
    end,
  },

}
