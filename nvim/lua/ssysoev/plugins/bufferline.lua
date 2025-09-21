return {
  {
    -- tabs
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "tabs",
        separator_style = "thick",
        diagnostics = "nvim_lsp",
        color_icons = true,
        always_show_bufferline = false,
      },
    }
  },
}
