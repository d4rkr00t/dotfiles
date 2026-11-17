-- Stats dashboard for commander: a float showing which keymaps you lean on,
-- which ones have gone cold, and which commands deserve a key.
local M = {}

local stats = require("ssysoev.custom.commander.stats")

local DEAD_DAYS = 30 -- last used longer ago than this -> dead
local TOP_N = 10 -- rows in TOP
local DEAD_N = 10 -- rows in DEAD
local FORGOTTEN_N = 5 -- rows in FORGOTTEN
local BIND_N = 5 -- rows in BIND ME
local PALETTE_MIN = 3 -- palette runs before a command counts as "used often"
local BAR_W = 18 -- width of the TOP bars
local DESC_W = 34 -- width of the description column
local MIN_W = 72 -- never narrower than this
local MIN_W_PCT = 0.5 -- ...nor narrower than half the editor
local MAX_W_PCT = 0.9
local MIN_H_PCT = 0.5 -- never shorter than half the editor
local MAX_H_PCT = 0.85

local function rpad(text, width)
  return text .. string.rep(" ", math.max(0, width - #text))
end

local function lpad(text, width)
  return string.rep(" ", math.max(0, width - #text)) .. text
end

local function trunc(text, width)
  if #text <= width then
    return text
  end

  return text:sub(1, width - 3) .. "..."
end

local function by(field)
  return function(a, b)
    return a[field] > b[field]
  end
end

local function widest(rows, text)
  local width = 0
  for _, row in ipairs(rows) do
    width = math.max(width, #text(row))
  end
  return width
end

-- Assemble a line out of { text, highlight } pieces, tracking byte columns
local function chunks(pieces)
  local text, highlights, column = "", {}, 0

  for _, piece in ipairs(pieces) do
    if piece[2] then
      table.insert(highlights, { column, column + #piece[1], piece[2] })
    end
    text = text .. piece[1]
    column = column + #piece[1]
  end

  return text, highlights
end

-- Flatten the registry into per-key rows and per-command rows
local function collect(registry, data)
  local keys, commands = {}, {}

  for _, entry in ipairs(registry) do
    local palette = data["palette|" .. entry.desc]
    local command = {
      desc = entry.desc,
      palette = palette and palette.count or 0,
      keys = {},
      key_count = 0,
    }

    for _, key in ipairs(entry.keys or {}) do
      local counted = data[key[1] .. "|" .. key[2]]
      local row = {
        label = key[1] .. " " .. key[2],
        desc = entry.desc,
        count = counted and counted.count or 0,
        age = stats.age_days(counted and counted.last or stats.today()),
      }

      command.key_count = command.key_count + row.count
      table.insert(command.keys, row)
      table.insert(keys, row)
    end

    table.insert(commands, command)
  end

  return keys, commands
end

-- Turn the registry into buffer lines plus the extmarks that colour them
local function render(registry, data)
  local keys, commands = collect(registry, data)

  local lines, marks = {}, {}

  local function add(text, highlights)
    table.insert(lines, text)
    for _, highlight in ipairs(highlights or {}) do
      table.insert(marks, { #lines - 1, highlight[1], highlight[2], highlight[3] })
    end
  end

  -- fmt(rows) returns the per-row function producing that row's chunks
  local function section(title, source, keep, order, limit, fmt)
    local rows = vim.tbl_filter(keep, source)
    table.sort(rows, by(order))
    rows = vim.list_slice(rows, 1, limit)

    add("")
    add(chunks({ { " " .. title, "Title" } }))
    if #rows == 0 then
      add(chunks({ { "  nothing yet", "NonText" } }))
      return
    end

    local pieces = fmt(rows)
    for _, row in ipairs(rows) do
      add(chunks(pieces(row)))
    end
  end

  -- header
  local presses, dead_count = 0, 0
  for _, row in ipairs(keys) do
    presses = presses + row.count
    if row.age > DEAD_DAYS then
      dead_count = dead_count + 1
    end
  end

  local palette_runs, palette_only, seen = 0, 0, {}
  for _, command in ipairs(commands) do
    -- two entries can share a desc, and then they share the palette counter too
    if not seen[command.desc] then
      seen[command.desc] = true
      palette_runs = palette_runs + command.palette
    end
    if #command.keys == 0 then
      palette_only = palette_only + 1
    end
  end

  local dead_pct = 0
  if #keys > 0 then
    dead_pct = math.floor(dead_count / #keys * 100 + 0.5)
  end

  add(chunks({
    { " ", nil },
    { tostring(#registry), "Number" },
    { " cmds · ", "Comment" },
    { tostring(#keys), "Number" },
    { " keys · ", "Comment" },
    { tostring(presses), "Number" },
    { " presses · ", "Comment" },
    { tostring(palette_runs), "Number" },
    { " palette runs", "Comment" },
  }))
  add(chunks({
    { " ", nil },
    { tostring(dead_count), "Number" },
    { " dead (" .. dead_pct .. "%) · ", "Comment" },
    { tostring(palette_only), "Number" },
    { " palette-only", "Comment" },
  }))

  section("TOP", keys, function(row)
    return row.count > 0
  end, "count", TOP_N, function(rows)
    local label_w = widest(rows, function(row) return row.label end)
    local count_w = widest(rows, function(row) return tostring(row.count) end)
    local max = rows[1].count

    return function(row)
      local filled = math.max(1, math.floor(row.count / max * BAR_W + 0.5))
      return {
        { "  " .. rpad(row.label, label_w) .. "  ", "Identifier" },
        { string.rep("█", filled), "String" },
        { string.rep(" ", BAR_W - filled) .. "  ", nil },
        { lpad(tostring(row.count), count_w), "Number" },
      }
    end
  end)

  section("DEAD  (>" .. DEAD_DAYS .. "d)", keys, function(row)
    return row.age > DEAD_DAYS
  end, "age", DEAD_N, function(rows)
    local label_w = widest(rows, function(row) return row.label end)

    return function(row)
      return {
        { "  " .. rpad(row.label, label_w) .. "  ", "Identifier" },
        { rpad(trunc(row.desc, DESC_W), DESC_W) .. "  ", "Comment" },
        { lpad(row.age .. "d", 5), "DiagnosticWarn" },
      }
    end
  end)

  -- has a key, but you keep reaching for the palette instead
  section("FORGOTTEN  (palette ≫ key)", commands, function(command)
    return #command.keys > 0 and command.palette >= PALETTE_MIN and command.palette > command.key_count
  end, "palette", FORGOTTEN_N, function(rows)
    local label_w = widest(rows, function(command) return command.keys[1].label end)

    return function(command)
      return {
        { "  " .. rpad(command.keys[1].label, label_w) .. "  ", "Identifier" },
        { rpad(trunc(command.desc, DESC_W), DESC_W) .. "  ", "Comment" },
        { "key ", "Comment" },
        { lpad(tostring(command.key_count), 3), "Number" },
        { "  pal ", "Comment" },
        { lpad(tostring(command.palette), 3), "Number" },
      }
    end
  end)

  -- no key at all, yet you run it often
  section("BIND ME  (no key, used often)", commands, function(command)
    return #command.keys == 0 and command.palette >= PALETTE_MIN
  end, "palette", BIND_N, function()
    return function(command)
      return {
        { "  " .. rpad(trunc(command.desc, DESC_W), DESC_W) .. "  ", "Comment" },
        { "pal ", "Comment" },
        { lpad(tostring(command.palette), 3), "Number" },
      }
    end
  end)

  add("")

  return lines, marks
end

-- Open the dashboard in a float
-- @param registry table
M.open = function(registry)
  local lines, marks = render(registry, stats.snapshot())

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local namespace = vim.api.nvim_create_namespace("commander_stats")
  for _, mark in ipairs(marks) do
    vim.api.nvim_buf_set_extmark(buf, namespace, mark[1], mark[2], {
      end_col = mark[3],
      hl_group = mark[4],
    })
  end

  vim.bo[buf].modifiable = false

  local width = math.max(MIN_W, math.floor(vim.o.columns * MIN_W_PCT))
  for _, line in ipairs(lines) do
    width = math.max(width, vim.fn.strdisplaywidth(line) + 2)
  end

  local height = math.max(#lines, math.floor(vim.o.lines * MIN_H_PCT))

  Snacks.win({
    buf = buf,
    title = " Commander stats ",
    title_pos = "center",
    border = "rounded",
    width = math.min(width, math.floor(vim.o.columns * MAX_W_PCT)),
    height = math.min(height, math.floor(vim.o.lines * MAX_H_PCT)),
    wo = {
      wrap = false,
      number = false,
      relativenumber = false,
      signcolumn = "no",
      cursorline = false,
    },
    keys = { q = "close", ["<Esc>"] = "close" },
  })
end

return M
