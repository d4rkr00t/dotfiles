local safe_reqiure = require("ssysoev.utils.safe-require")

safe_reqiure({ "command_center", "lint" }, function(mods)
  local cc = mods.command_center
  local lint = mods.lint

  lint.linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    svelte = { "eslint_d" },
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
