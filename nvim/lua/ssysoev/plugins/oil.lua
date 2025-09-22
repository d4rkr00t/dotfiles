return {
  --
  -- file tree
  --
  {
    "stevearc/oil.nvim",
    lazy = true,
    cmd = { "Oil" },
    opts = {
      cleanup_delay_ms = 100,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<Esc><Esc>"] = { callback = "actions.close", mode = "n" },
        ["<C-v>"] = { callback = "actions.select_vsplit" },
        ["<leader>fs"] = {
          callback = function()
            local fzf = require("fzf-lua")
            local current_dir = require("oil").get_current_dir()

            fzf.live_grep({ cwd = current_dir })
          end,
        },
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons", "ibhagwan/fzf-lua" },
  }
}
