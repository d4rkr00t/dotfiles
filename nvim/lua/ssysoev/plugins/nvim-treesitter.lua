return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install { "vim", "markdown", "lua", "jsx", "tsx", "typescript", "rust", "go", "python", "zig", "json", "json5", "regex" }
    end
  },
}
