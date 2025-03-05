local ts_js_common = {
  { trigger = "cl", body = "console.log(${1});" },
  { trigger = "clj", body = "console.log(JSON.stringify(${1}, null, 2));" },
  { trigger = "fun", body = "function ${1:name}(${2:args}) { $0 }" },
  { trigger = "rbt", body = "Math.floor(Math.random() * ($0 - $1 + 1)) + $1;" },
}

local M = {
  lua = {
    { trigger = "fun", body = "function ${1:name}(${2:args}) $0 end" },
  },
  javascript = ts_js_common,
  typescript = ts_js_common,
  typescriptreact = ts_js_common,
}

return M
