local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "cmp", "luasnip", "lspkind" }, function(mods)
  local cmp = mods.cmp
  local luasnip = mods.luasnip
  local lspkind = mods.lspkind
  local vscode_lazy_loader = require("luasnip/loaders/from_vscode")
  local types = require("luasnip.util.types")

  -- Comparator form nvim-cmp that prioritises certain lsp item types (kind) over the others
  local lspkind_comparator = function(conf)
    local lsp_types = require("cmp.types").lsp
    return function(entry1, entry2)
      if entry1.source.name ~= "nvim_lsp" then
        if entry2.source.name == "nvim_lsp" then
          return false
        else
          return nil
        end
      end
      local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
      local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

      local priority1 = conf.kind_priority[kind1] or 0
      local priority2 = conf.kind_priority[kind2] or 0
      if priority1 == priority2 then
        return nil
      end
      return priority2 < priority1
    end
  end

  luasnip.setup({
    history = true,
    region_check_events = "CursorHold,InsertLeave",
    delete_check_events = "TextChanged,InsertEnter,InsertLeave",
    updateevents = "TextChanged,TextChangedI",
    -- Show virtual text hints for node types
    ext_opts = {
      [types.insertNode] = {
        active = {
          virt_text = { { "●", "Operator" } },
        },
      },
      [types.choiceNode] = {
        active = {
          virt_text = { { "●", "Constant" } },
        },
      },
    },
  })

  -- load vs-code like snippets from plugins (e.g. friendly-snippets)
  vscode_lazy_loader.lazy_load()
  local vscode_snippets = "~/Dropbox/Apps/vscode/snippets"
  local vscode_loader_status = pcall(vscode_lazy_loader.lazy_load, { paths = { vscode_snippets } })
  if not vscode_loader_status then
    print("Couldn't load vscode snippets")
  end

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,preview,noselect",
      autocomplete = false,
    },

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<M- >"] = cmp.mapping.complete(), -- show completion suggestions
      ["<C-e>"] = cmp.mapping.abort(), -- close completion window
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),

    -- sources for autocompletion
    sources = {
      { name = "nvim_lsp" }, -- lsp data completion
      { name = "buffer", keyword_length = 2, max_item_count = 5 }, -- text within current buffer
      { name = "path", keyword_length = 3, max_item_count = 4 }, -- file system paths
      { name = "luasnip", keyword_length = 2, max_item_count = 4 }, -- snippets
      { name = "nvim_lsp_signature_help" },
      { name = "copilot" }, -- copilot data source
    },

    sorting = {
      comparators = {
        lspkind_comparator({
          kind_priority = {
            Field = 11,
            Property = 11,
            Constant = 10,
            Enum = 10,
            EnumMember = 10,
            Event = 10,
            Function = 10,
            Method = 10,
            Operator = 10,
            Reference = 10,
            Struct = 10,
            Variable = 9,
            File = 8,
            Folder = 8,
            Class = 5,
            Color = 5,
            Module = 5,
            Keyword = 2,
            Constructor = 1,
            Interface = 1,
            Snippet = 0,
            Text = 1,
            TypeParameter = 1,
            Unit = 1,
            Value = 1,
          },
        }),
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.kind,
      },
    },

    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },

    -- window = {
    --   completion = cmp.config.window.bordered(),
    --   documentation = cmp.config.window.bordered(),
    -- },
    window = {
      completion = cmp.config.window.bordered({
        col_offset = -3,
        side_padding = 0,
        top_padding = 0,
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }),
      documentation = cmp.config.window.bordered({
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }),
    },

    -- configure lspkind for vs-code like icons
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
        kind.kind = " " .. strings[1] .. " "

        local menu = " (" .. strings[2] .. ") "
        if kind.menu then
          menu = menu .. kind.menu
        end

        kind.menu = menu

        return kind
      end,
    },
    -- formatting = {
    --   fields = {
    --     cmp.ItemField.Abbr,
    --     cmp.ItemField.Kind,
    --     cmp.ItemField.Menu,
    --   },
    --   format = lspkind.cmp_format({
    --     maxwidth = 55,
    --     ellipsis_char = "...",
    --     menu = {
    --       buffer = "[buf]",
    --       nvim_lsp = "[lsp]",
    --       copilot = "[copilot]",
    --       luasnip = "[snip]",
    --     },
    --   }),
    -- },
  })
end)
