return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true, size = 1 * 1024 * 1024, notify = true },
      gitbrowse = {
        enabled = true,
        url_patterns = {
          ["bitbucket%.org"] = {
            branch = "/src/{branch}",
            file = "/src/{branch}/{file}#lines-{line_start}:{line_end}",
            permalink = "/src/{commit}/{file}#lines-{line_start}:{line_end}",
            commit = "/commits/{commit}",
          },
        }
      },
      input = { enabled = true },
      picker = {
        enabled = true,
        ui_select = true,
        live_limit = 100000,
        hidden = true,
        layout = {
          preset = "bottom",
        },
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true }
    },
  },
}
