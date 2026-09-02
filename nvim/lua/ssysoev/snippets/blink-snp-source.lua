local M = {}

function M.new()
  return setmetatable({}, { __index = M })
end

function M:get_completions(ctx, callback)
  local snips = require("ssysoev.snippets.snippets").get_buf_snips()

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
