local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "lspkind" }, function(mods)
  local lspkind = mods.lspkind
  lspkind.init({
    mode = "symbol",
    preset = "codicons",
    symbol_map = {
      Copilot = "",
    },
  })
end)
