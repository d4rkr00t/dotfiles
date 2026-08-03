return {
  {
    -- add, delete, change surroundings (vim-surround-compatible mappings)
    "nvim-mini/mini.surround",
    keys = { "cs", "ds", "ys", { "S", mode = "x" } },
    config = function()
      require("mini.surround").setup({
        -- vim-surround emulation, so cs/ds/ys muscle memory still works
        mappings = {
          add = "ys",
          delete = "ds",
          replace = "cs",
          find = "",
          find_left = "",
          highlight = "",
          update_n_lines = "",
          suffix_last = "",
          suffix_next = "",
        },
        search_method = "cover_or_next",
      })

      -- vim-surround uses S in visual mode, and yss for the whole line
      pcall(vim.keymap.del, "x", "ys")
      vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
      vim.keymap.set("n", "yss", "ys_", { remap = true })
    end,
  },
}
