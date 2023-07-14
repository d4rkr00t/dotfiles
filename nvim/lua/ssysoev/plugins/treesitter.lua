local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "nvim-treesitter.configs" }, function(mods)
  local treesitter = mods["nvim-treesitter.configs"]

  -- configure treesitter
  treesitter.setup({
    -- enable syntax highlighting
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = { "NvimTree" },
    },
    -- enable indentation
    indent = {
      enable = true,
    },
    -- enable autotagging (w/ nvim-ts-autotag plugin)
    autotag = {
      enable = true,
      filetypes = {
        "html",
        "xml",
        "javascript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
      },
    },
    -- ensure these language parsers are installed
    ensure_installed = {
      "help",
      "bash",
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "markdown",
      "svelte",
      "graphql",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "go",
      "rust",
      "python",
      "swift",
      "glsl",
    },
    -- auto install above language parsers
    auto_install = true,

    incremental_selection = {
      enable = false,
      keymaps = {},
    },

    playground = {
      enable = true,
    },

    context_commentstring = {
      enable = true,
    },
  })
end)
