return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install { "vim", "markdown", "lua", "jsx", "tsx", "typescript", "rust", "go", "python", "zig", "json", "json5" }
    end
  },
}
