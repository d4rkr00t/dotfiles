local safe_require = require("ssysoev.utils.safe-require")
local M = {}

safe_require({ "cmp" }, function()
  local global_snippets = {}
  local snippets_by_filetype = require("ssysoev.snippets.snippets-by-ft")

  local function get_buf_snips()
    local ft = vim.bo.filetype
    local snips = vim.list_slice(global_snippets)

    if ft and snippets_by_filetype[ft] then
      vim.list_extend(snips, snippets_by_filetype[ft])
    end

    return snips
  end

  local function register_cmp_source()
    local cmp_source = {}
    local cache = {}
    function cmp_source.complete(_, _, callback)
      local bufnr = vim.api.nvim_get_current_buf()
      if not cache[bufnr] then
        local completion_items = vim.tbl_map(function(s)
          ---@type lsp.CompletionItem
          local item = {
            word = s.trigger,
            label = s.trigger,
            kind = vim.lsp.protocol.CompletionItemKind.Snippet,
            insertText = s.body,
            insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
          }
          return item
        end, get_buf_snips())

        cache[bufnr] = completion_items
      end

      callback(cache[bufnr])
    end

    require("cmp").register_source("snp", cmp_source)
  end

  register_cmp_source()

  local function get_cursor_0ind()
    local c = vim.api.nvim_win_get_cursor(0)
    c[1] = c[1] - 1
    return c
  end

  -- pos: (0,0)-indexed.
  local function line_chars_before(pos)
    -- cur-rows are 1-indexed, api-rows 0.
    local line = vim.api.nvim_buf_get_lines(0, pos[1], pos[1] + 1, false)
    return string.sub(line[1], 1, pos[2])
  end

  -- returns current line with text up-to and excluding the cursor.
  local function get_current_line_to_cursor()
    return line_chars_before(get_cursor_0ind())
  end

  M.expand = function()
    local line_content = get_current_line_to_cursor()
    local snips = get_buf_snips()
    for _, snip in ipairs(snips or {}) do
      local snip_match = string.find(line_content, "%s+" .. snip.trigger .. "$")
        or string.find(line_content, "^" .. snip.trigger .. "$")
      if snip_match then
        local cursor = get_cursor_0ind()
        vim.api.nvim_buf_set_text(0, cursor[1], cursor[2] - string.len(snip.trigger), cursor[1], cursor[2], { "" })
        vim.snippet.expand(snip.body)
        return true
      end
    end
    return false
  end
end)

return M
