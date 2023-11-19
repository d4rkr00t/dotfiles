local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "mini.comment" }, function(mods)
  vim.g.skip_ts_context_commentstring_module = true

  local comment = mods["mini.comment"]
  comment.setup({
    custom_commentstring = function()
      return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
    end,
  })
end)
