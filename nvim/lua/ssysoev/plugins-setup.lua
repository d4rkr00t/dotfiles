return {
  -- lua functions that many plugins use
  "nvim-lua/plenary.nvim",

  --
  -- file tree
  --
  {
    "nvim-tree/nvim-tree.lua",
    tag = "nightly",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    config = function()
      require("ssysoev.plugins.nvim-tree")
    end,
  },

  {
    "stevearc/oil.nvim",
    lazy = true,
    cmd = { "Oil" },
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  --
  -- UI niceties
  --

  -- colorscheme
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    cond = vim.g.THEME == "carbonfox",
    config = function()
      local nightfox = require("nightfox")
      nightfox.setup({
        options = {
          styles = {
            comments = "italic",
            keywords = "bold",
            functions = "italic,bold",
          },
          inverse = {
            search = true,
          },
        },
      })

      pcall(vim.cmd, "colorscheme carbonfox")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    cond = vim.g.THEME == "catppuccin",
    config = function()
      local catppuccin = require("catppuccin")

      pcall(vim.cmd, "colorscheme catppuccin")

      catppuccin.setup({
        dim_inactive = {
          enabled = false,
        },
        integrations = {
          bufferline = true,
          cmp = true,
          fidget = true,
          gitsigns = true,
          lsp_saga = true,
          lsp_trouble = true,
          mason = true,
          noice = true,
          nvimtree = true,
          symbols_outline = true,
          telescope = {
            enabled = true,
            -- style = "nvchad",
          },
          treesitter = true,
          navic = {
            enabled = true,
            custom_bg = "NONE",
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    cond = vim.g.THEME == "tokyonight",
    config = function()
      require("tokyonight").setup({
        style = "night",
        on_colors = function(colors)
          colors.border = "#384062"
        end,
      })
      pcall(vim.cmd, "colorscheme tokyonight")
    end,
  },
  {
    "jesseleite/nvim-noirbuddy",
    lazy = false,
    cond = vim.g.THEME == "noirbuddy",
    dependencies = { { "tjdevries/colorbuddy.nvim", branch = "dev" } },
    config = function()
      require("noirbuddy").setup({
        preset = "miami-nights",
      })
    end,
  },

  -- better quickfix list
  { "kevinhwang91/nvim-bqf" },

  {
    -- tabs
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    config = function()
      require("ssysoev.plugins.bufferline")
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  {
    -- vs-code like icons for autocompletion
    "onsails/lspkind.nvim",
    event = "VeryLazy",
    config = function()
      require("ssysoev.plugins.lspkind")
    end,
  },

  {
    -- status line
    "nvim-lualine/lualine.nvim",
    config = function()
      require("ssysoev.plugins.lualine")
    end,
  },

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
      require("fidget").setup()
    end,
  },

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    init = function()
      require("ssysoev.plugins.dressing")
    end,
  },

  {
    "gelguy/wilder.nvim",
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })
      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer({
          highlighter = wilder.basic_highlighter(),
          left = { " ", wilder.popupmenu_devicons() },
          right = { " ", wilder.popupmenu_scrollbar() },
        })
      )
    end,
  },

  --
  -- fuzzy finder
  --
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "FzfLua" },
    init = function()
      require("fzf-lua").setup({
        "max-perf",
        keymap = {
          fzf = {
            ["CTRL-Q"] = "select-all+accept",
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      -- keymaps util and help
      {
        "FeiyouG/command_center.nvim",
        commit = "0d820c438c871fe31ed942bc592a070da1564141",
      },
    },
    config = function()
      require("ssysoev.plugins.telescope")
    end,
  },

  --
  -- quick editing / editing niceties
  --
  {
    -- add, delete, change surroundings
    "tpope/vim-surround",
    keys = { "cs", "ds", "ys" },
  },

  {
    -- commenting with gc
    "echasnovski/mini.comment",
    event = "VeryLazy",
    config = function()
      require("ssysoev.plugins.comment")
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  {
    -- highlight colors
    "norcalli/nvim-colorizer.lua",
    cmd = { "ColorizerToggle" },
    config = function()
      require("ssysoev.plugins.colorizer")
    end,
  },

  -- automatically create missing folders on file save
  {
    "jghauser/mkdir.nvim",
  },

  -- better text-objects
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
    },
    config = function()
      require("ssysoev.plugins.mini-ai")
    end,
  },

  --
  -- copilot
  --
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = "InsertEnter",
    config = function()
      vim.schedule(function()
        require("ssysoev.plugins.copilot")
      end)
    end,
  },

  --
  -- completion
  --
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("ssysoev.plugins.nvim-cmp")
    end,
    event = "InsertEnter",
    dependencies = {
      -- sources
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },

      -- snippets
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
      },
    },
  },

  --
  -- lsp
  --
  {
    -- in charge of managing lsp servers, linters & formatters
    "williamboman/mason.nvim",
    event = { "VeryLazy" },
    config = function()
      require("ssysoev.plugins.lsp.init")
    end,
    dependencies = {
      -- bridges gap b/w mason & lspconfig
      "williamboman/mason-lspconfig.nvim",

      -- easily configure language servers
      "neovim/nvim-lspconfig",

      -- additional functionality for typescript server (e.g. rename file & update imports)
      {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        config = function() end,
      },

      -- plugin providing access to the SchemaStore catalog.
      "b0o/schemastore.nvim",

      -- configure formatters & linters
      {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
          require("ssysoev.plugins.conform")
        end,
      },
      {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
          require("ssysoev.plugins.nvim-lint")
        end,
      },

      {
        "glepnir/lspsaga.nvim",
        event = "BufRead",
        config = function()
          require("ssysoev.plugins.lsp.lspsaga")
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
      },
    },
  },

  {
    -- list view for diagnostics
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "Trouble" },
    config = function()
      require("ssysoev.plugins.lsp.trouble")
    end,
  },

  --
  --
  -- Treesitter
  --
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("ssysoev.plugins.treesitter")
    end,
  },

  {
    -- keeps current context visible e.g. function declaration, same as in vscode
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("ssysoev.plugins.treesitter-context")
    end,
  },

  {
    -- treesitter based navigation and selection
    "Dkendal/nvim-treeclimber",
    config = function()
      require("ssysoev.plugins.nvim-treeclimber")
    end,
  },

  {
    "Wansmer/treesj",
    cmd = { "TSJToggle" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
  },

  --
  -- auto closing
  --
  {
    -- autoclose parens, brackets, quotes, etc...
    "windwp/nvim-autopairs",
    config = function()
      require("ssysoev.plugins.autopairs")
    end,
  },

  {
    -- autoclose tags
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  --
  -- git integration
  --
  {
    -- show line modifications on left hand side
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("ssysoev.plugins.gitsigns")
    end,
  },

  {
    -- generates shareable link to a git repo, similar to open-in-github vscode plugin
    "d4rkr00t/gitlinker.nvim",
    event = "VeryLazy",
    branch = "timeout",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("ssysoev.plugins.gitlinker")
    end,
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },

  -- visual window switcher
  {
    url = "https://gitlab.com/yorickpeterse/nvim-window.git",
    event = "VeryLazy",
    config = function()
      require("ssysoev.plugins.nvim-window")
    end,
  },
}
