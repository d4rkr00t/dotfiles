return {
  {
    -- commenting with gc
    "nvim-mini/mini.comment",
    keys = { "gc", "gcc" },
    config = function()
      vim.g.skip_ts_context_commentstring_module = true

      local comment = require("mini.comment")
      comment.setup({
        custom_commentstring = function()
          return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
        end,
      })
    end,
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
          enable_autocmd = false,
        },
      },
    },
  },
}
