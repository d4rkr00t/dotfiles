return {
  --
  -- fuzzy finder
  --
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    cmd = { "FzfLua" },
    config = function()
      require("fzf-lua").setup({
        { "max-perf", "ivy" },

        git = {
          status = {
            cmd = "git -c color.status=false --no-optional-locks status --porcelain=v1",
          },
        },

        oldfiles = {
          cwd_only = true,
          stat_file = true,
          include_current_session = true,
        },

        keymap = {
          fzf = {
            ["CTRL-Q"] = "select-all+accept",
          },
        },
      })

      -- replace vim.ui.select with fzf-lua
      require('fzf-lua').register_ui_select()
    end,
  },
}
