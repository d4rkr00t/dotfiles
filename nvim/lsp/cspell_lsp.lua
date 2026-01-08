local get_mason_bin_path = require("ssysoev.utils.get-mason-bin-path")

return {
  cmd = { get_mason_bin_path("cspell-lsp"), '--stdio' }
}
