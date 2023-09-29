local ft = require("guard.filetype")

ft("javascript"):fmt("prettier")
ft("typescript"):fmt("prettier")
ft("typescriptreact"):fmt("prettier")
ft("json"):fmt("prettier")
ft("map"):fmt("prettier")
ft("svelte"):fmt("prettier")

ft("lua"):fmt("stylua")

ft("go"):fmt("lsp")

ft("rust"):fmt("rustfmt")

-- call setup LAST
require("guard").setup({
  fmt_on_save = true,
  lsp_as_default_formatter = true,
})
