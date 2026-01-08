local get_mason_bin_path = function(name)
  return vim.fn.expand("$MASON/bin/" .. name)
end

return get_mason_bin_path
