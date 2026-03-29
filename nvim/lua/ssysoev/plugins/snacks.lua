return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true, size = 1 * 1024 * 1024, notify = true },
      gitbrowse = { enabled = true },
      input = { enabled = true },
      picker = {
        enabled = true,
        ui_select = true,
        layout = {
          preset = "bottom",
        },
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true }
    },
  },
}
