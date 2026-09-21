local M = {}

M.picker = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local attached = vim.lsp.get_clients({ bufnr = bufnr })
  local attached_names = {}
  for _, client in ipairs(attached) do
    attached_names[client.name] = true
  end

  local items = {}
  for _, client in ipairs(attached) do
    items[#items + 1] = { text = client.name, name = client.name, attached = true }
  end

  for _, config in ipairs(vim.lsp.get_configs({ enabled = true })) do
    if not attached_names[config.name] then
      items[#items + 1] = { text = config.name, name = config.name, attached = false }
    end
  end

  table.sort(items, function(a, b) return a.text < b.text end)

  Snacks.picker.pick({
    title = "LSP Clients",
    items = items,
    format = function(item)
      return { { item.text, item.attached and "Normal" or "Comment" } }
    end,
    confirm = function(picker, item)
      picker:close()
      if not item then return end

      if not item.attached then
        vim.cmd("lsp enable " .. item.name)
        return
      end

      vim.ui.select({ "Stop", "Restart" }, { prompt = item.name }, function(choice)
        if choice == "Stop" then
          vim.cmd("lsp stop " .. item.name)
        elseif choice == "Restart" then
          vim.cmd("lsp restart " .. item.name)
        end
      end)
    end,
  })
end

return M
