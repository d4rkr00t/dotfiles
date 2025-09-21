return {
  {
    -- keeps current context visible e.g. function declaration, same as in vscode
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      enabled = true,
      max_lines = 3,
    }
  },
}
