return {
  {
    "rebelot/kanagawa.nvim",
    cond = vim.g.THEME == "kanagawa",
    init = function()
      require("kanagawa").setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        keywordStyle = { italic = false },
        commentStyle = { italic = false },
        colors = { -- add/modify theme and palette colors
          theme = {
            dragon = {
              ui = {
                fg = "#f5f5f5",
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
                  fg = "#f5f5f5",
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
                comment = "#515051",

                string = "#6ad0b7",
                number = "#6ad0b7",

                constant = "#f5f5f5",
                variable = "#FFCFA8",
                -- identifier = "#f5f5f5",
                identifier = "#FFCFA8",
                fun = "#FFC799",
                parameter = "#f5f5f5",
                statement = "#A0A0A0",
                operator = "#A0A0A0",
                keyword = "#A0A0A0",
                preproc = "#ffffff",
                type = "#f5f5f5",

                regex = "#A0A0A0",
                deprecated = "#A0A0A0",
                punct = "#65737E",

                special1 = "#FFCFA8",
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
            },
          },
        },
        background = {
          dark = "dragon",
        },
        overrides = function(colors)
          return {
            Boolean                      = { fg = "#6ad0b7" },
            Property                     = { fg = "#6ad0b7" },
            Field                        = { fg = "#6ad0b7" },
            Operator                     = { fg = "#A0A0A0" },
            ["typescriptBinaryOp"]       = { fg = "#A0A0A0" },
            ["typescriptPredefinedType"] = { fg = "#FFCFA8" },
            Exception                    = { fg = "#FFCFA8" },
            ["@property"]                = { fg = "#FFCFA8" },
            ["tsxAttrib"]                = { fg = "#FFCFA8" }
          }
        end,
      })

      pcall(vim.cmd, "colorscheme kanagawa-dragon")
    end,
  },
}
