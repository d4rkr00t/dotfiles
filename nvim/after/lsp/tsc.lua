-- lspconfig's `tsc` resolves `<root_dir>/node_modules/.bin/tsc` first with no
-- version check, but `--lsp` only exists in TypeScript 7. Repos pinned to TS 5
-- die instantly with TS5023, so pin mason's TS 7 build.
return {
  exit_timeout = true,
  cmd = { require("ssysoev.utils.get-mason-bin-path")("tsc"), "--lsp", "--stdio" },
}
