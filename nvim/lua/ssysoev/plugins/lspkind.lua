return {
  {
    -- vs-code like icons for autocompletion
    "onsails/lspkind.nvim",
    event = "VeryLazy",
    config = function()
      local lspkind = require("lspkind")
      lspkind.init({
        mode = "symbol",
        preset = "codicons",
        symbol_map = {
          Copilot = "",
        },
      })
    end,
  },
}
