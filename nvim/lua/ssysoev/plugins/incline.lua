return {
  -- lightweight floating statuslines
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup({
        hide = {
          focused_win = true,
          only_win = true
        }
      })
    end,
    event = "VeryLazy",
  },
}
