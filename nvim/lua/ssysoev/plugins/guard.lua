local ft = require("guard.filetype")

ft("javascript"):fmt("prettier")
ft("typescript"):fmt("prettier")
ft("typescriptreact"):fmt("prettier")
ft("map"):fmt("prettier")
ft("svelte"):fmt("prettier")

ft("lua"):fmt("stylua")

-- call setup LAST
require("guard").setup({
  fmt_on_save = true,
})
