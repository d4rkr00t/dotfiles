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
                preproc = "#b0b0b0",
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
}
