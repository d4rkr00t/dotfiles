return {
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local snippets = require("ssysoev.snippets.snippets")

      cmp.setup({
        view = {
          entries = {
            follow_cursor = true,
          },
        },
        completion = {
          completeopt = "menu,menuone,preview,noselect",
          autocomplete = false,
        },

        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<M- >"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-i>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(),    -- close completion window
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.snippet.active({ direction = 1 }) then
              vim.snippet.jump(1)
            elseif snippets.expand() then
            else
              fallback()
            end
          end, { "i", "s", "n" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.snippet.active({ direction = -1 }) then
              vim.snippet.jump(-1)
            else
              fallback()
            end
          end, { "i", "s", "n" }),
        }),

        -- sources for autocompletion
        sources = {
          { name = "nvim_lsp" },                                                       -- lsp data completion
          { name = "buffer",                 keyword_length = 2, max_item_count = 5 }, -- text within current buffer
          { name = "path",                   keyword_length = 3, max_item_count = 4 }, -- file system paths
          { name = "nvim_lsp_signature_help" },
          { name = "snp" },
        },

        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },

        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },

        window = {
          completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
          },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = lspkind.cmp_format({
              mode = "symbol_text",
              maxwidth = 50,
              menu = {
                buffer = "[buf]",
                nvim_lsp = "[lsp]",
                copilot = "[copilot]",
                luasnip = "[snip]",
              },
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            local menu = "    (" .. (strings[2] or "") .. ")"
            if kind.menu then
              menu = menu .. " " .. kind.menu
            end

            kind.menu = menu

            return kind
          end,
        },
      })

      -- Customization for Pmenu
      vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#6e6a86", bg = "NONE", strikethrough = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#ea9a97", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#ea9a97", bg = "NONE", bold = true })

      vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#232136", bg = "#eb6f92" })
      vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#232136", bg = "#eb6f92" })
      vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#232136", bg = "#eb6f92" })

      vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#232136", bg = "#9FBD73" })
      vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#232136", bg = "#9FBD73" })
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#232136", bg = "#9FBD73" })

      vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#232136", bg = "#D4BB6C" })
      vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#232136", bg = "#D4BB6C" })
      vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#232136", bg = "#D4BB6C" })

      vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#232136", bg = "#c4a7e7" })
      vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#232136", bg = "#c4a7e7" })
      vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#232136", bg = "#c4a7e7" })
      vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#232136", bg = "#c4a7e7" })
      vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#232136", bg = "#c4a7e7" })

      vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#232136", bg = "#908caa" })
      vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#232136", bg = "#908caa" })

      vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#232136", bg = "#f6c177" })
      vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#232136", bg = "#f6c177" })
      vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#232136", bg = "#f6c177" })

      vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#232136", bg = "#3e8fb0" })
      vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#232136", bg = "#3e8fb0" })
      vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#232136", bg = "#3e8fb0" })

      vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#232136", bg = "#9ccfd8" })
      vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#232136", bg = "#9ccfd8" })
      vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#232136", bg = "#9ccfd8" })
    end,
    event = "InsertEnter",
    dependencies = {
      -- sources
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "onsails/lspkind.nvim",
    },
  },
}
