local M = {}

function M.new()
  return setmetatable({}, { __index = M })
end

function M:get_completions(ctx, callback)
  local snippets_by_filetype = require("ssysoev.snippets.snippets-by-ft")
  local ft = vim.bo.filetype
  local snips = {}

  if ft and snippets_by_filetype[ft] then
    vim.list_extend(snips, snippets_by_filetype[ft])
  end

  local items = vim.tbl_map(function(s)
    return {
      label = s.trigger,
      kind = vim.lsp.protocol.CompletionItemKind.Snippet,
      insertText = s.body,
      insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
    }
  end, snips)

  callback({
    is_incomplete_forward = false,
    is_incomplete_backward = false,
    items = items,
  })
end

return M
