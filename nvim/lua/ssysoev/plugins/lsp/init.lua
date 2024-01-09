local bootstrap = require("ssysoev.plugins.lsp.bootstrap")
local merge_tables = require("ssysoev.utils.merge-tables")
local safe_require = require("ssysoev.utils.safe-require")

-- enable keybindings for attached lsp servers
local on_attach = function(client, buffer)
  -- disable semantic highlighting
  client.server_capabilities.semanticTokensProvider = nil

  -- set keybinds
  safe_require({ "command_center" }, function(mods)
    local cc = mods.command_center

    -- keybind options
    local opts = { noremap = true, silent = true, buffer = buffer }

    cc.add({
      {
        desc = "Show definitions",
        cmd = "<cmd>Telescope lsp_definitions<CR>",
        keys = { "n", "gd", opts },
      },

      {
        desc = "Peek definitions",
        cmd = "<cmd>Lspsaga peek_definition<CR>",
        keys = { "n", "gpd", opts },
      },

      {
        desc = "Open definition in a split",
        cmd = "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>",
        keys = { "n", "gs", opts },
      },

      {
        desc = "Show references",
        cmd = "<cmd>FzfLua lsp_references<CR>",
        keys = { "n", "gr", opts },
      },

      {
        desc = "Show references [lspsaga]",
        cmd = "<cmd>Lspsaga finder<CR>",
        keys = { "n", "gR", opts },
      },

      {
        desc = "Show implementation",
        cmd = "<cmd>FzfLua lsp_implementations<CR>",
      },

      {
        desc = "Go to declaration",
        cmd = "<cmd>lua vim.lsp.buf.definition()<CR>",
        keys = { "n", "gD", opts },
      },

      {
        desc = "Go to implementation",
        cmd = "<cmd>lua vim.lsp.buf.implementation()<CR>",
        keys = { "n", "gi", opts },
      },

      {
        desc = "Code actions",
        cmd = "<cmd>Lspsaga code_action<cr>",
        keys = { "n", "<leader>la", opts },
      },

      {
        desc = "Smart rename",
        cmd = vim.lsp.buf.rename,
        keys = { "n", "<leader>rn", opts },
      },

      {
        desc = "Show line diagnostics",
        cmd = function()
          local float_opts = {
            focusable = true,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "line",
          }
          vim.diagnostic.open_float(nil, float_opts)
        end,
        keys = { "n", "<leader>d", opts },
      },

      {
        desc = "Jump to previous diagnostic",
        cmd = function()
          vim.diagnostic.goto_prev()
        end,
        keys = { "n", "[d", opts },
      },

      {
        desc = "Jump to next diagnostic",
        cmd = function()
          vim.diagnostic.goto_next()
        end,
        keys = { "n", "]d", opts },
      },

      {
        desc = "Show documentation",
        -- cmd = "<cmd>Lspsaga hover_doc<cr>",
        cmd = function()
          vim.lsp.buf.hover()
        end,
        keys = { "n", "K", opts },
      },

      {
        desc = "Highlight occurences of the word under cursor",
        cmd = "<cmd>lua vim.lsp.buf.document_highlight()<CR>",
        keys = { "n", "<leader>hh", opts },
      },

      {
        desc = "Signature documentation",
        cmd = vim.lsp.buf.signature_help,
        keys = { "i", "<C-k>", opts },
      },
    })
  end)

  vim.api.nvim_exec(
    [[
          augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
    ]],
    false
  )
end

local diagnostics_signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(diagnostics_signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  update_in_insert = true,
  underline = true,
  float = {
    focusable = true,
    style = "full",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
  signs = {
    active = diagnostics_signs,
  },
  virtual_text = {
    spacing = 4,
    prefix = "",
    severity = vim.diagnostic.severity.ERROR,
  },
})

local config = {
  tsserver = {
    type = "lsp",
    setup_lsp = function(lspconfig, defaults)
      lspconfig["tsserver"].setup(merge_tables(defaults, {
        on_attach = on_attach,
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern("tsconfig.json")(fname)
        end,
        settings = {
          typescript = {
            tsserver = {
              maxTsServerMemory = 8192,
            },
            suggest = {
              completeFunctionCalls = true,
            },
            preferGoToSourceDefinition = true,
          },
          javascript = {
            implicitProjectConfig = {
              checkJs = true,
            },
            suggest = {
              completeFunctionCalls = true,
            },
            preferGoToSourceDefinition = true,
          },
        },
      }))
    end,
    -- setup_lsp = function()
    --   safe_require({ "typescript-tools" }, function(mods)
    --     mods["typescript-tools"].setup({
    --       on_attach = on_attach,
    --       settings = {
    --         publish_diagnostic_on = "insert_leave",
    --         separate_diagnostic_server = false,
    --         tsserver_max_memory = "auto",
    --       },
    --     })
    --   end)
    -- end,
  },
  lua_ls = {
    type = "lsp",
    setup_lsp = function(lspconfig, defaults)
      local runtime_path = vim.split(package.path, ";")
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      lspconfig["lua_ls"].setup(merge_tables(defaults, {
        on_attach = on_attach,
        settings = {
          -- custom settings for lua
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
                runtime_path,
              },
              checkThirdParty = false,
            },
          },
        },
      }))
    end,
  },
  rust_analyzer = {
    type = "lsp",
    setup_lsp = function(lspconfig, defaults)
      lspconfig["rust_analyzer"].setup(merge_tables(defaults, {
        on_attach = on_attach,
        -- root_dir = function(fname)
        --   return util.root_pattern("Cargo.toml")(fname)
        -- end,
        settings = {
          ["rust-analyzer"] = {
            files = {
              excludeDirs = { "__example__" },
            },
          },
        },
      }))
    end,
  },
  jsonls = {
    type = "lsp",
    setup_lsp = function(lspconfig, defaults)
      lspconfig["jsonls"].setup(merge_tables(defaults, {
        on_attach = on_attach,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      }))
    end,
  },
  html = { type = "lsp" },
  cssls = { type = "lsp" },
  pylsp = { type = "lsp" },
  gopls = { type = "lsp" },
}

bootstrap(config, on_attach)

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
