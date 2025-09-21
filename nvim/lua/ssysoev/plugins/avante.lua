return {
  --
  -- AI crap
  --
  {
    "yetone/avante.nvim",
    build = function()
      if vim.g.IS_MAC then
        return "make BUILD_FROM_SOURCE=true"
      else
        return "make"
      end
    end,
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {},
    config = function()
      local atl_avante = require("ssysoev.custom.atl-avante")

      require("avante").setup({
        provider = "atlgemini",
        providers = vim.tbl_deep_extend("force", {}, atl_avante),
        windows = {
          width = 40,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  }
}
