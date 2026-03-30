return {
  {
    "saghen/blink.cmp",
    lazy = false,
    version = "*",
    opts = {
      keymap = {
        preset = "none",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<M- >"] = { "show", "fallback" },
        ["<C-o>"] = { "show", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          "select_next",
          "snippet_forward",
          function()
            return require("ssysoev.snippets.snippets").expand()
          end,
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },

      completion = {
        list = {
          selection = { preselect = true, auto_insert = false },
        },

        accept = {
          -- let nvim-autopairs handle bracket insertion
          auto_brackets = { enabled = false },
        },

        ghost_text = { enabled = true },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },

        menu = {
          draw = {
            columns = {
              { "kind_icon" },
              { "label",    "label_description", gap = 1 },
              { "kind",     "source_name",       gap = 1 },
            },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local icon, _ = require("mini.icons").get("lsp", ctx.kind)
                  return " " .. icon .. " "
                end,
                highlight = function(ctx)
                  return "BlinkCmpKind" .. ctx.kind
                end,
              },
              kind = {
                text = function(ctx)
                  return "(" .. ctx.kind .. ")"
                end,
              },
              source_name = {
                text = function(ctx)
                  local labels = {
                    lsp      = "[lsp]",
                    buffer   = "[buf]",
                    path     = "[path]",
                    snippets = "[snip]",
                    snp      = "[snip]",
                  }
                  return labels[ctx.source_name] or ("[" .. ctx.source_name .. "]")
                end,
              },
            },
          },
        },
      },

      sources = {
        default = { "lsp", "buffer", "path", "snippets", "snp" },
        providers = {
          buffer = {
            min_keyword_length = 2,
            max_items = 5,
          },
          path = {
            min_keyword_length = 3,
            max_items = 4,
          },
          snp = {
            name = "snp",
            module = "ssysoev.snippets.blink-snp-source",
          },
        },
      },

      signature = { enabled = true },

      snippets = { preset = "default" },
    },
  },
}
