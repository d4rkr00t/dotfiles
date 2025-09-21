return {
  -- lightweight floating statuslines
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup()
    end,
    event = "VeryLazy",
  },
}
