local function reload_config()
	for name, _ in pairs(package.loaded) do
		if name:match("ssysoev") then
			package.loaded[name] = nil
		end
	end
	dofile(vim.env.MYVIMRC)
end

return reload_config
