-- Usage tracking for commander.
--
-- Counts live in memory for the length of the session and are merged into a
-- json file on exit, so several nvim instances never clobber each other's
-- numbers. Ids are "<mode>|<lhs>" for keymaps and "palette|<desc>" for runs
-- from the command palette.
local M = {}

local path = vim.fn.stdpath("data") .. "/commander-stats.json"

-- counted this session only, not yet on disk
local session = {}

local function read()
  local file = io.open(path, "r")
  if file == nil then
    return {}
  end

  local content = file:read("*a")
  file:close()

  local ok, decoded = pcall(vim.json.decode, content)
  if not ok or type(decoded) ~= "table" then
    return {}
  end

  return decoded
end

local function write(stats)
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")

  local file = io.open(path, "w")
  if file == nil then
    return
  end

  file:write(vim.json.encode(stats))
  file:close()
end

M.today = function()
  return os.date("%Y-%m-%d")
end

-- Count one use of `id`. Called from expr mappings, so it must never touch disk.
M.hit = function(id)
  local entry = session[id]
  if entry == nil then
    session[id] = { count = 1 }
  else
    entry.count = entry.count + 1
  end
end

-- Every id a registry entry owns: one per keymap, plus one for palette runs
M.ids_of = function(entry)
  local ids = { "palette|" .. entry.desc }

  for _, key in ipairs(entry.keys or {}) do
    table.insert(ids, key[1] .. "|" .. key[2])
  end

  return ids
end

-- Age of a "YYYY-MM-DD" stamp in days
M.age_days = function(stamp)
  local year, month, day = tostring(stamp):match("^(%d+)-(%d+)-(%d+)$")
  if year == nil then
    return 0
  end

  local then_at = os.time({
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
    hour = 12,
  })

  return math.max(0, math.floor(os.difftime(os.time(), then_at) / 86400))
end

local function merge(stats)
  local stamp = M.today()

  for id, delta in pairs(session) do
    local entry = stats[id] or { count = 0 }
    entry.count = entry.count + delta.count
    entry.last = stamp
    stats[id] = entry
  end

  return stats
end

-- What is on disk plus what this session has not written yet
M.snapshot = function()
  return merge(read())
end

-- Merge the session into the file. Deltas land first, so seeding an unseen id
-- can never overwrite a fresh count.
M.flush = function(registry)
  local stats = merge(read())
  local stamp = M.today()

  -- Seed ids we have never seen with today's date, so a keymap added now ages
  -- into "dead" on its own instead of looking abandoned from birth.
  for _, entry in ipairs(registry) do
    for _, id in ipairs(M.ids_of(entry)) do
      if stats[id] == nil then
        stats[id] = { count = 0, last = stamp }
      end
    end
  end

  write(stats)

  -- the session now lives on disk, so forget it and stay idempotent
  session = {}
end

-- Drop ids no registry entry owns any more. Returns how many went.
M.prune = function(registry)
  local stats = read()

  local live = {}
  for _, entry in ipairs(registry) do
    for _, id in ipairs(M.ids_of(entry)) do
      live[id] = true
    end
  end

  local dropped = 0
  for id in pairs(stats) do
    if not live[id] then
      stats[id] = nil
      dropped = dropped + 1
    end
  end

  write(stats)

  return dropped
end

return M
