return {
  {
    -- keeps current context visible e.g. function declaration, same as in vscode
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      max_lines = 3,
    }
  },
}
