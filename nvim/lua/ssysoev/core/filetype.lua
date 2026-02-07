vim.filetype.add({
  filename = {
    [".env"] = "sh",
    [".envrc"] = "sh",
    ["*.js.map"] = "json",
    ["*.json"] = "json",
    ["*.css.map"] = "json",
    ["tsconfig.json"] = "jsonc",
  },
})
