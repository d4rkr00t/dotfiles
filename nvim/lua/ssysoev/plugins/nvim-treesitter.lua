return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')

      ts.install {
        "vim",
        "markdown",
        "lua",
        "javascript",
        "tsx",
        "typescript",
        "rust",
        "go",
        "python",
        "zig",
        "json",
        "json5",
        "regex",
        "html",
        "css",
      }

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_autostart", { clear = true }),
        callback = function(args)
          local ft = args.match
          if ft == "" then return end

          local lang = vim.treesitter.language.get_lang(ft) or ft

          -- Already installed: just start highlighting.
          if vim.tbl_contains(ts.get_installed("parsers"), lang) then
            pcall(vim.treesitter.start, args.buf, lang)
            return
          end

          -- A parser exists upstream: install it, then start highlighting.
          if vim.tbl_contains(ts.get_available(), lang) then
            ts.install({ lang }):await(function()
              if vim.api.nvim_buf_is_valid(args.buf) then
                pcall(vim.treesitter.start, args.buf, lang)
              end
            end)
            return
          end

          -- No treesitter parser: fall back to Vim's built-in syntax.
          if not pcall(vim.treesitter.start, args.buf, lang) then
            vim.bo[args.buf].syntax = "ON"
          end
        end,
      })
    end
  },
}
