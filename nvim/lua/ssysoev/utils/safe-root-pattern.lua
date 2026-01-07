local function safe_root_pattern(...)
  local exist, lspconfig = pcall(require, "nvim-lspconfig")
  if not exist then
    return nil
  end

  return lspconfig.util.root_pattern(...)
end

return safe_root_pattern
