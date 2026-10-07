return {
  {
    "nvim-mini/mini.base16",
    cond = vim.g.theme == "ember",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("ember")
    end,
  },
}
