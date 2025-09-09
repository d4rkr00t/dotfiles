local safe_require = require("ssysoev.utils.safe-require")

return {
  -- lua functions that many plugins use
  "nvim-lua/plenary.nvim",

  --
  -- file tree
  --
  {
    "stevearc/oil.nvim",
    lazy = true,
    cmd = { "Oil" },
    opts = {
      cleanup_delay_ms = 100,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<Esc><Esc>"] = { callback = "actions.close", mode = "n" },
        ["<C-v>"] = { callback = "actions.select_vsplit" },
        ["<leader>fs"] = {
          callback = function()
            safe_require({ "fzf-lua" }, function(mods)
              local current_dir = require("oil").get_current_dir()

              local fzf = mods["fzf-lua"]
              fzf.live_grep({ cwd = current_dir })
            end)
          end,
        },
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
                -- whitespace = "#625e5a",
                -- nontext = "#625e5a",
                whitespace = "#312D2A",
                nontext = "#312D2A",

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

                float = {
                  fg = "#A0A0A0",
                  bg = "#161616",
                  fg_border = "#282828",
                  bg_border = "#101010",
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
        overrides = function(colors)
          return {}
        end,
      })
      pcall(vim.cmd, "colorscheme kanagawa-dragon")
    end,
  },

  -- lightweight floating statuslines
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup()
    end,
    event = "VeryLazy",
  },

  -- better quickfix list
  {
    "kevinhwang91/nvim-bqf",
    event = "FileType qf",
    -- cond = false,
    -- config = function()
    --   local bqf_pv_timer
    --   require("bqf").setup({
    --     preview = {
    --       should_preview_cb = function(bufnr, qwinid)
    --         local bufname = vim.api.nvim_buf_get_name(bufnr)
    --         if bufname:match("^fugitive://") and not vim.api.nvim_buf_is_loaded(bufnr) then
    --           if bqf_pv_timer and bqf_pv_timer:get_due_in() > 0 then
    --             bqf_pv_timer:stop()
    --             bqf_pv_timer = nil
    --           end
    --           bqf_pv_timer = vim.defer_fn(function()
    --             vim.api.nvim_buf_call(bufnr, function()
    --               vim.cmd(("do fugitive BufReadCmd %s"):format(bufname))
    --             end)
    --             require("bqf.preview.handler").open(qwinid, nil, true)
    --           end, 60)
    --         end
    --         return true
    --       end,
    --     },
    --   })
    -- end,
  },

  {
    -- tabs
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    config = function()
      require("ssysoev.plugins.bufferline")
    end,
  },

  -- icons
  {
    "nvim-mini/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
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
    lazy = true,
    cmd = { "FzfLua" },
    config = function()
      require("fzf-lua").setup({
        { "max-perf", "ivy" },

        git = {
          status = {
            cmd = "git -c color.status=false --no-optional-locks status --porcelain=v1",
          },
        },

        oldfiles = {
          cwd_only = true,
          stat_file = true,
          include_current_session = true,
        },

        keymap = {
          fzf = {
            ["CTRL-Q"] = "select-all+accept",
          },
        },
      })
    end,
  },

  -- {
  --   "elanmed/fzf-lua-frecency.nvim",
  --   opts = {
  --    cwd_only = true,
  --   },
  -- },

  -- {
  --   "otavioschwanck/fzf-lua-enchanted-files",
  --   cmd = { "FzfLuaFiles" },
  --   dependencies = { "ibhagwan/fzf-lua" },
  --   config = function()
  --     -- Modern configuration using vim.g
  --     vim.g.fzf_lua_enchanted_files = {
  --       max_history_per_cwd = 50,
  --     }
  --   end,
  -- },

  {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar" },
    config = function()
      require("grug-far").setup({
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      })
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
    "nvim-mini/mini.comment",
    keys = { "gc", "gcc" },
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
    "nvim-mini/mini.ai",
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
  -- snippets
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("ssysoev.plugins.nvim-cmp")
    end,
    event = "InsertEnter",
    dependencies = {
      -- sources
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  },

  --
  -- lsp
  --
  {
    -- in charge of managing lsp servers, linters & formatters
    "williamboman/mason.nvim",
    commit = "fc98833b6da5de5a9c5b1446ac541577059555be",
    event = { "VeryLazy" },
    config = function()
      require("ssysoev.plugins.lsp.init")
    end,
    dependencies = {
      -- bridges gap b/w mason & lspconfig
      {
        "williamboman/mason-lspconfig.nvim",
        commit = "1a31f824b9cd5bc6f342fc29e9a53b60d74af245",
      },

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
    keys = { "<M-j>", "<M-k>" },
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
      -- scope = "git_branch",
    },
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
  },

  -- close unused buffers
  {
    "chrisgrieser/nvim-early-retirement",
    opts = {
      retirementAgeMins = 10,
    },
    event = "VeryLazy",
  },

  --
  -- AI crap
  --
  {
    "yetone/avante.nvim",
    build = function()
      if vim.g.IS_MAC then
        return "make BUILD_FROM_SOURCE=true"
      else
        return "make"
      end
    end,
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {},
    config = function()
      local atl_avante = require("ssysoev.custom.atl-avante")

      require("avante").setup({
        provider = "atlgemini",
        providers = vim.tbl_deep_extend("force", {}, atl_avante),
        windows = {
          width = 40,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  },

  --
  -- Local dev plugins
  --

  {
    -- "d4rkr00t/execa.nvim",
    dir = "~/Development/execa.nvim",
    cmd = "Execa",
    opts = {
      split = "vsplit",
      verbose = false,
      confirm = true,
      commands = {
        cargo_test = "cargo test $EX_FN",

        afm_integration_test = "yarn test:integration $EX_FILE_PATH_REL --reuse-dev-server --retries=0",
        afm_integration_test_trace = "yarn test:integration $EX_FILE_PATH_REL --reuse-dev-server --trace=on --retries=0",

        afm_unit_test = "yarn test $EX_FILE_PATH_REL",

        afm_gemini_test = "yarn test:vr $EX_FILE_PATH_REL",
        afm_gemini_informational_test = "yarn test:vr-informational $EX_FILE_PATH_REL",

        npm_version = "npm view $EX_STR version",
        npm_all_versions = "npm view $EX_STR versions",
        npm_src_url = "open https://unpkg.com/browse/$EX_STR/",
        npm_url = "open https://npmjs.com/package/$EX_STR/",

        cursor_current_file = "cursor -r $EX_CWD -g $EX_FILE_PATH_REL:$EX_LINE:$EX_COL",

        execa_test = "echo $EX_CWD $EX_FN $EX_FILE_PATH_REL:$EX_LINE:$EX_COL",
      },
    },
  },
}
