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
        "toml",
        "regex",
        "html",
        "css",
      }

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_autostart", { clear = true }),
        callback = function(args)
          local ft = args.match
          if ft == "" or vim.bo[args.buf].buftype ~= "" then return end

          local lang = vim.treesitter.language.get_lang(ft) or ft

          if pcall(vim.treesitter.start, args.buf, lang) then
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          else
            vim.opt_local.foldmethod = "indent"
            vim.bo[args.buf].syntax = "ON"
          end
        end,
      })
    end
  },
}
