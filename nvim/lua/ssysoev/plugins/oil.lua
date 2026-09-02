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
            local current_dir = require("oil").get_current_dir()
            Snacks.picker.grep({ cwd = current_dir })
          end,
        },
        ["<leader>fo"] = {
          callback = function()
            local dir = require("oil").get_current_dir()
            if dir then
              vim.system({ "open", dir })
            end
          end,
          desc = "Open current folder in Finder",
          mode = "n",
        },
      },
    },
  }
}
