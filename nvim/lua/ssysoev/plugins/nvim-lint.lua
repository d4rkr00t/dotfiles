local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "lint" }, function(mods)
  local cc = require("ssysoev.custom.commander")
  local lint = mods.lint

  lint.linters_by_ft = {
    -- javascript = { "eslint" },
    -- typescript = { "eslint" },
    -- javascriptreact = { "eslint" },
    -- typescriptreact = { "eslint" },
    -- svelte = { "eslint" },
    json = {},
  }

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })

  cc.add({
    {
      desc = "Lint file",
      cmd = function()
        lint.try_lint()
      end,
      keys = { "n", "<leader>ll", { noremap = true, silent = true } },
    },
  })
end)
