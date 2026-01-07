local root_pattern = require("ssysoev.utils.safe-root-pattern")

return {
  filetypes = { "zig", "zir" },
  root_dir = root_pattern("zls.json", "build.zig", ".git"),
  single_file_support = true,
  settings = {
    zig_lib_path = "/opt/homebrew/Cellar/zig/0.15.1/lib/zig",
    enable_build_on_save = true
  },
}
