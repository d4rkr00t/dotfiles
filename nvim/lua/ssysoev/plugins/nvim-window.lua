local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "nvim-window" }, function(mods)
  local nvim_window = mods["nvim-window"]
  nvim_window.setup({
    chars = {
      "w",
      "e",
      "d",
      "s",
      "c",
      "r",
      "q",
      "a",
      "m",
      "k",
      "l",
      "j",
      "f",
    },
  })
end)
