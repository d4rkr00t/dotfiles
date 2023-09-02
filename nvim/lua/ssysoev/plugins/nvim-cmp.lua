local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "cmp", "luasnip", "lspkind" }, function(mods)
  local cmp = mods.cmp
  local luasnip = mods.luasnip
  local lspkind = mods.lspkind
  local vscode_lazy_loader = require("luasnip/loaders/from_vscode")
  local types = require("luasnip.util.types")

  luasnip.setup({
    history = true,
    region_check_events = "CursorHold,InsertLeave",
    delete_check_events = "TextChanged,InsertEnter",
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

  vim.opt.completeopt = "menu,menuone,noselect"

  cmp.setup({
    completion = {
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
      { name = "nvim_lsp", keyword_length = 1 }, -- lsp data completion
      { name = "buffer", keyword_length = 2, max_item_count = 5 }, -- text within current buffer
      { name = "path", keyword_length = 3, max_item_count = 4 }, -- file system paths
      { name = "luasnip", keyword_length = 2, max_item_count = 4 }, -- snippets
      { name = "nvim_lsp_signature_help" },
      { name = "copilot" }, -- copilot data source
    },

    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        -- require("cmp-under-comparator").under,
        cmp.config.compare.kind,
      },
    },

    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    -- configure lspkind for vs-code like icons
    formatting = {
      fields = {
        cmp.ItemField.Abbr,
        cmp.ItemField.Kind,
        cmp.ItemField.Menu,
      },
      format = lspkind.cmp_format({
        maxwidth = 60,
        ellipsis_char = "...",
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[lsp]",
          copilot = "[copilot]",
          luasnip = "[snip]",
        },
      }),
    },
  })
end)
