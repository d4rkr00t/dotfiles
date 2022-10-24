-- import alpha-nvim safely
local alpha_setup, alpha = pcall(require, "alpha")
if not alpha_setup then
	return
end

alpha.setup(require("alpha.themes.startify").config)
