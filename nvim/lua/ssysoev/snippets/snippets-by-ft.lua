local ts_js_common = {
  { trigger = "cl", body = "console.log(${1});" },
  { trigger = "clj", body = "console.log(JSON.stringify(${1}, null, 2));" },
  { trigger = "fun", body = "function ${1:name}(${2:args}) { $0 }" },
}

local M = {
  lua = {
    { trigger = "fun", body = "function ${1:name}(${2:args}) $0 end" },
  },
  javascript = ts_js_common,
  typescript = ts_js_common,
}

return M
