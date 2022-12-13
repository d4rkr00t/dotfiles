local function safe_require(path, cb)
	local res = {}

	for _, name in pairs(path) do
		local exist, mod = pcall(require, name)
		if not exist then
			if vim.g.VERBOSE_LOG then
				print("Plugin ", name, " failed to load!")
			end
			return false
		end
		res[name] = mod
	end

	return cb(res)
end

return safe_require
