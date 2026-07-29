vim.filetype.add({
  filename = {
    [".env"] = "sh",
    [".envrc"] = "sh",
    ["tsconfig.json"] = "jsonc",
  },
  pattern = {
    [".*%.css%.map"] = "json",
    [".*%.js%.map"] = "json",
  },
})
