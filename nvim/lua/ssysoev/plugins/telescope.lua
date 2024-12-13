local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "telescope" }, function(mods)
  local telescope = mods.telescope

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
    extensions = {},
  })
end)
