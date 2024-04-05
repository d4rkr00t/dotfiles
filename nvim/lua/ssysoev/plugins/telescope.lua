local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "telescope", "command_center" }, function(mods)
  local telescope = mods.telescope
  local command_center = mods.command_center

  telescope.setup({
    defaults = {
      preview = {
        filesize_limit = 0.1, -- MB
        treesitter = false,
      },
      sorting_strategy = "ascending",
      layout_strategy = "flex",
      layout_config = {
        horizontal = {
          prompt_position = "top",
        },
        preview_cutoff = 120,
      },
      file_ignore_patterns = { "^node_modules/", "^.git/", "**/*.snap$" },
      path_display = { "truncate" },
      color_devicons = true,
    },
    extensions = {
      command_center = {
        components = {
          command_center.component.DESC,
          command_center.component.KEYS,
        },
        sort_by = {
          command_center.component.DESC,
          command_center.component.KEYS,
        },
        auto_replace_desc_with_cmd = false,
      },
    },
  })

  telescope.load_extension("command_center")
end)
