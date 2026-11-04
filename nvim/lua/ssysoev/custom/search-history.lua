local M = {}

local PATH = vim.fn.stdpath("data") .. "/search-history.jsonl"
local MIN_LEN = 4
local MAX_ENTRIES = 1000

local sources = {
  grep = { icon = "\u{f002}", hl = "SnacksPickerSpecial", field = "search" },
  smart = { icon = "\u{f15b}", hl = "SnacksPickerDirectory", field = "pattern" },
}

---@param picker snacks.Picker
M.record = function(picker)
  local name = picker.opts.source
  if not sources[name] then return end
  local query = picker.input.filter[sources[name].field]
  if #query < MIN_LEN then return end
  local entry = {
    source = name,
    pattern = picker.input.filter.pattern,
    search = picker.input.filter.search,
    cwd = vim.fn.getcwd(),
    time = os.time(),
  }
  vim.fn.writefile({ vim.json.encode(entry) }, PATH, "a")
end

local function read()
  local ok, lines = pcall(vim.fn.readfile, PATH)
  if not ok then return {} end
  if #lines > 2 * MAX_ENTRIES then
    lines = vim.list_slice(lines, #lines - MAX_ENTRIES + 1)
    vim.fn.writefile(lines, PATH)
  end
  return vim.tbl_map(vim.json.decode, lines)
end

-- newest first, current cwd only; drops repeats and queries that are a prefix of another query
local function collect()
  local cwd = vim.fn.getcwd()
  local entries = vim.tbl_filter(function(e) return e.cwd == cwd end, read())
  for _, e in ipairs(entries) do
    e.text = e[sources[e.source].field]
  end

  local items, seen = {}, {}
  for i = #entries, 1, -1 do
    local e = entries[i]
    local key = e.source .. "\0" .. e.text
    local is_prefix = vim.iter(entries):any(function(o)
      return o.source == e.source and #o.text > #e.text and vim.startswith(o.text, e.text)
    end)
    if seen[key] then
      seen[key].count = seen[key].count + 1
    elseif not is_prefix then
      e.count = 1
      seen[key] = e
      table.insert(items, e)
    end
  end
  return items
end

M.picker = function()
  Snacks.picker.pick({
    title = "Search history",
    items = collect(),
    layout = { preview = false },
    matcher = { sort_empty = false },
    format = function(item)
      local ret = {
        { sources[item.source].icon .. " ", sources[item.source].hl },
        { item.text, "SnacksPickerFile" },
      }
      if item.source == "grep" and item.pattern ~= "" then
        table.insert(ret, { "  > " .. item.pattern, "SnacksPickerComment" })
      end
      table.insert(ret, {
        col = 0,
        virt_text = {
          { item.count > 1 and ("×" .. item.count .. "  ") or "", "SnacksPickerComment" },
          { Snacks.picker.util.reltime(item.time), "SnacksPickerTime" },
        },
        virt_text_pos = "right_align",
        hl_mode = "combine",
      })
      return ret
    end,
    confirm = function(picker, item)
      picker:close()
      if not item then return end
      if item.source == "grep" then
        Snacks.picker.grep({ search = item.search, pattern = item.pattern })
      else
        Snacks.picker.smart({ pattern = item.pattern, filter = { cwd = true } })
      end
    end,
  })
end

return M
