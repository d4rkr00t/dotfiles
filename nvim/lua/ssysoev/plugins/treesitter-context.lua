local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "treesitter-context" }, function(mods)
  local treesitter_context = mods["treesitter-context"]

  treesitter_context.setup({
    enabled = true,
    max_lines = 3,
  })
end)
