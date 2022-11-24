local function safe_require(path, cb)
	local res = {}

	for i, name in pairs(path) do
		local exist, mod = pcall(require, name)
		if not exist then
			return false
		end
		res[name] = mod
	end

	return cb(res)
end

return safe_require
