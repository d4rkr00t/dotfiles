local safe_require = require("ssysoev.utils.safe-require")

safe_require({ "nvim-window" }, function(mods)
	local nvim_window = mods["nvim-window"]
	nvim_window.setup({})
end)
