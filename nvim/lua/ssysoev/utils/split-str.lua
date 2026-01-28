local function split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  local i = 0
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, i, str)
    i = i + 1
  end
  return t
end

return split
