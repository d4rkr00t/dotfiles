return {
  -- lua functions that many plugins use
  "nvim-lua/plenary.nvim",

  --
  -- file tree
  --
  {
    "nvim-tree/nvim-tree.lua",
    -- tag = "nightly",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    config = function()
      require("ssysoev.plugins.nvim-tree")
    end,
  },

  {
    "stevearc/oil.nvim",
    lazy = true,
    cmd = { "Oil" },
    opts = {
      cleanup_delay_ms = 100,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<Esc><Esc>"] = { callback = "actions.close", mode = "n" },
        ["<C-v>"] = { callback = "actions.select_vsplit" },
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  --
  -- UI niceties
  --

  -- colorscheme
  {
    "rebelot/kanagawa.nvim",
    cond = vim.g.THEME == "kanagawa",
    init = function()
      require("kanagawa").setup({
        compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        keywordStyle = { italic = false },
        commentStyle = { italic = false },
        colors = { -- add/modify theme and palette colors
          theme = {
            dragon = {
              ui = {
                fg = "#ffffff",
                fg_dim = "#A0A0A0",
                fg_reverse = "#505050",

                bg_dim = "#101010",
                bg_gutter = "#101010",

                bg_m3 = "#000000",
                bg_m2 = "#101010",
                bg_m1 = "#161616",
                bg = "#101010",
                bg_p1 = "#101010",
                bg_p2 = "#242525",

                special = "#7a8382",
                whitespace = "#625e5a",
                nontext = "#625e5a",

                bg_visual = "#242525",
                bg_search = "#a0a0a0",

                pmenu = {
                  fg = "#ffffff",
                  fg_sel = "none",
                  bg = "#101010",
                  bg_sel = "#242525",
                  bg_thumb = "#101010",
                  bg_sbar = "#101010",
                },
                --
                float = {
                  fg = "#A0A0A0",
                  bg = "#161616",
                  -- fg_border = palette.sumiInk6,
                  -- bg_border = "#282828",
                  -- hello
                },
              },
              syn = {
                string = "#99FFE4",
                variable = "#ffffff",
                number = "#FFC799",
                constant = "#FFC799",
                identifier = "#FFC799",
                parameter = "#A0A0A0",
                fun = "#FFC799",
                statement = "#FFC799",
                keyword = "#A0A0A0",
                operator = "#A0A0A0",
                preproc = "#A0A0A0",
                -- preproc = "#FF8080",
                type = "#FFC799",
                regex = "#A0A0A0",
                deprecated = "#A0A0A0",
                punct = "#A0A0A0",
                comment = "#515051",
                special1 = "#FFC799",
                special2 = "#A0A0A0",
                special3 = "#A0A0A0",
              },
              diag = {
                error = "#FF8080",
                ok = "#99FFE4",
                warning = "#FFC799",
                info = "#A0A0A0",
                hint = "#6A9589",
              },
              diff = {
                add = "#283E38",
                delete = "#3C2526",
                change = "#3B332A",
                text = "#242525",
              },
              vcs = {
                added = "#99FFE4",
                removed = "#FF8080",
                changed = "#FFC799",
              },
              -- term = {
              --   palette.dragonBlack0, -- black
              --   palette.dragonRed, -- red
              --   palette.dragonGreen2, -- green
              --   palette.dragonYellow, -- yellow
              --   palette.dragonBlue2, -- blue
              --   palette.dragonPink, -- magenta
              --   palette.dragonAqua, -- cyan
              --   palette.oldWhite, -- white
              --   palette.dragonGray, -- bright black
              --   palette.waveRed, -- bright red
              --   palette.dragonGreen, -- bright green
              --   palette.carpYellow, -- bright yellow
              --   palette.springBlue, -- bright blue
              --   palette.springViolet1, -- bright magenta
              --   palette.waveAqua2, -- bright cyan
              --   palette.dragonWhite, -- bright white
              --   palette.dragonOrange, -- extended color 1
              --   palette.dragonOrange2, -- extended color 2
              -- },
            },
          },
        },
        background = {
          dark = "dragon",
        },
      })
      pcall(vim.cmd, "colorscheme kanagawa-dragon")
    end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    cond = vim.g.THEME == "rose-pine",
    config = function()
      require("rose-pine").setup({
        extend_background_behind_borders = true,
        styles = {
          bold = true,
          italic = false,
          transparency = false,
        },
      })
      pcall(vim.cmd, "colorscheme rose-pine-moon")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    cond = vim.g.THEME == "catppuccin",
    config = function()
      local catppuccin = require("catppuccin")
      catppuccin.setup({
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
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
          markdown = true,
          noice = true,
          nvimtree = true,
          symbols_outline = true,
          telescope = {
            enabled = true,
            style = "nvchad",
          },
          treesitter = true,
        },
        custom_highlights = function(C)
          return {
            CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
            CmpItemKindKeyword = { fg = C.base, bg = C.red },
            CmpItemKindText = { fg = C.base, bg = C.teal },
            CmpItemKindMethod = { fg = C.base, bg = C.blue },
            CmpItemKindConstructor = { fg = C.base, bg = C.blue },
            CmpItemKindFunction = { fg = C.base, bg = C.blue },
            CmpItemKindFolder = { fg = C.base, bg = C.blue },
            CmpItemKindModule = { fg = C.base, bg = C.blue },
            CmpItemKindConstant = { fg = C.base, bg = C.peach },
            CmpItemKindField = { fg = C.base, bg = C.green },
            CmpItemKindProperty = { fg = C.base, bg = C.green },
            CmpItemKindEnum = { fg = C.base, bg = C.green },
            CmpItemKindUnit = { fg = C.base, bg = C.green },
            CmpItemKindClass = { fg = C.base, bg = C.yellow },
            CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
            CmpItemKindFile = { fg = C.base, bg = C.blue },
            CmpItemKindInterface = { fg = C.base, bg = C.yellow },
            CmpItemKindColor = { fg = C.base, bg = C.red },
            CmpItemKindReference = { fg = C.base, bg = C.red },
            CmpItemKindEnumMember = { fg = C.base, bg = C.red },
            CmpItemKindStruct = { fg = C.base, bg = C.blue },
            CmpItemKindValue = { fg = C.base, bg = C.peach },
            CmpItemKindEvent = { fg = C.base, bg = C.blue },
            CmpItemKindOperator = { fg = C.base, bg = C.blue },
            CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
            CmpItemKindCopilot = { fg = C.base, bg = C.teal },
          }
        end,
      })

      pcall(vim.cmd, "colorscheme catppuccin")
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

  -- better quickfix list
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    config = function()
      local bqf_pv_timer
      require("bqf").setup({
        preview = {
          should_preview_cb = function(bufnr, qwinid)
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname:match("^fugitive://") and not vim.api.nvim_buf_is_loaded(bufnr) then
              if bqf_pv_timer and bqf_pv_timer:get_due_in() > 0 then
                bqf_pv_timer:stop()
                bqf_pv_timer = nil
              end
              bqf_pv_timer = vim.defer_fn(function()
                vim.api.nvim_buf_call(bufnr, function()
                  vim.cmd(("do fugitive BufReadCmd %s"):format(bufname))
                end)
                require("bqf.preview.handler").open(qwinid, nil, true)
              end, 60)
            end
            return true
          end,
        },
      })
    end,
  },

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

  -- progress bar for lsp
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
      require("fidget").setup({})
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

  --
  -- fuzzy finder
  --
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    cmd = { "FzfLua" },
    config = function()
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
    event = "VeryLazy",
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
    -- keys = { "gc", "gcc" },
    config = function()
      require("ssysoev.plugins.comment")
    end,
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
          enable_autocmd = false,
        },
      },
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
    event = "VeryLazy",
  },

  {
    "LunarVim/bigfile.nvim",
    config = function()
      require("bigfile").setup({
        filesize = 1, -- size of the file in MiB, the plugin round file sizes to the closest MiB
        pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
        features = { -- features to disable
          "indent_blankline",
          "lsp",
          "treesitter",
          "syntax",
          "matchparen",
          "filetype",
          "vimopts",
        },
      })
    end,
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
    "github/copilot.vim",
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

      -- snippets
      {
        "L3MON4D3/LuaSnip",
        pin = true,
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
        -- cond = false,
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
    branch = "dev",
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
    event = "VeryLazy",
    config = function()
      require("ssysoev.plugins.treesitter-context")
    end,
  },

  {
    -- treesitter based navigation and selection
    "Dkendal/nvim-treeclimber",
    event = "InsertEnter",
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
    event = "InsertEnter",
    config = function()
      require("ssysoev.plugins.autopairs")
    end,
  },

  {
    -- autoclose tags
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
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
      require("gitsigns").setup()
    end,
  },

  {
    -- generates shareable link to a git repo, similar to open-in-github vscode plugin
    "linrongbin16/gitlinker.nvim",
    cmd = { "GitLink" },
    config = function()
      require("ssysoev.plugins.gitlinker")
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gvdiffsplit", "GcLog" },
  },

  -- visual window switcher
  {
    url = "https://gitlab.com/yorickpeterse/nvim-window.git",
    event = "VeryLazy",
    config = function()
      require("ssysoev.plugins.nvim-window")
    end,
  },

  -- experiments
  {
    "cbochs/grapple.nvim",
    cmd = "Grapple",
    opts = {
      scope = "git_branch",
    },
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
  },
}
