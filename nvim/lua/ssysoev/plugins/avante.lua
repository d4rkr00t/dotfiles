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
    keys = { '<leader>aa', '<leader>an' },
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {},
    config = function()
      local atl_avante = require("ssysoev.custom.atl-avante")
      ---@module 'avante'
      ---@type avante.Config
      require("avante").setup({
        -- provider = "gemini",
        provider = "atlgemini",
        providers = vim.tbl_deep_extend("force", {}, atl_avante),
        mode = "legacy",
        behaviour = {
          auto_focus_sidebar = true,
          auto_suggestions = true, -- Experimental stage
          auto_suggestions_respect_ignore = true,
          auto_set_highlight_group = true,
          auto_set_keymaps = true,
          auto_apply_diff_after_generation = true,
          jump_result_buffer_on_finish = false,
          support_paste_from_clipboard = false,
          minimize_diff = true,
          enable_token_counting = true,
          use_cwd_as_project_root = true,
          auto_focus_on_diff_view = false,
        },
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
