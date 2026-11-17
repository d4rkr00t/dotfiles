local M = {}

-- snippets for the current buffer's filetype
M.get_buf_snips = function()
  return require("ssysoev.snippets.snippets-by-ft")[vim.bo.filetype] or {}
end

M.expand = function()
  local line_content = vim.api.nvim_get_current_line():sub(1, vim.api.nvim_win_get_cursor(0)[2])
  for _, snip in ipairs(M.get_buf_snips()) do
    local snip_match = string.find(line_content, "%s+" .. snip.trigger .. "$")
      or string.find(line_content, "^" .. snip.trigger .. "$")
    if snip_match then
      -- blink.cmp runs this in an expr mapping (textlock active), so defer the
      -- buffer mutation to the next tick to avoid E565.
      vim.schedule(function()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        vim.api.nvim_buf_set_text(0, row - 1, col - #snip.trigger, row - 1, col, { "" })
        vim.snippet.expand(snip.body)
      end)
      return true
    end
  end
  return false
end

return M
