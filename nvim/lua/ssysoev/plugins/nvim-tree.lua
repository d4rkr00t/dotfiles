local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "nvim-tree" }, function(mods)
  local nvimtree = mods["nvim-tree"]

  local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set(
      "n",
      "<leader>fs",
      require("ssysoev.core.plugins.nvimtree-telescope").grep_at_current_tree_node,
      opts("Search in current folder")
    )
  end

  -- configure nvim-tree
  nvimtree.setup({
    on_attach = my_on_attach,
    git = {
      enable = false,
    },
    -- change folder arrow icons
    renderer = {
      indent_markers = {
        enable = true,
      },
      icons = {
        glyphs = {
          folder = {
            arrow_closed = "", -- arrow when folder is closed
            arrow_open = "", -- arrow when folder is open
          },
        },
      },
    },

    actions = {
      open_file = {
        resize_window = false,
        window_picker = {
          enable = true,
        },
      },
    },

    view = {
      side = "right",
      width = 40,
    },

    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = false,
      update_root = true,
    },

    diagnostics = {
      enable = false,
    },

    filesystem_watchers = {
      enable = true,
      debounce_delay = 200,
      ignore_dirs = { "node_modules", ".git" },
    },
  })
end)
