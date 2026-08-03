local function safe_require(path, cb)
  local res = {}

  for _, name in ipairs(path) do
    local exist, mod = pcall(require, name)
    if not exist then
      if vim.g.VERBOSE_LOG then
        vim.notify(("safe_require: %s failed to load"):format(name), vim.log.levels.WARN)
      end
      return false
    end
    res[name] = mod
  end

  return cb(res)
end

return safe_require
