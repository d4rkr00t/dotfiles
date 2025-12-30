local bootstrap = require("ssysoev.lsp.bootstrap")
local merge_tables = require("ssysoev.utils.merge-tables")
-- local safe_require = require("ssysoev.utils.safe-require")

-- enable keybindings for attached lsp servers
local on_attach = function(client)
  -- disable semantic highlighting
  -- client.server_capabilities.semanticTokensProvider = nil

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
  -- virtual_lines = {
  --   enabled = true,
  --   severity = vim.diagnostic.severity.ERROR,
  -- },
})

local config = {
  ts_ls = {
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
            reportStyleChecksAsWarnings = false,
            tsserver = {
              maxTsServerMemory = 12000,
              nodePath = "node",
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
    --         tsserver_file_preferences = {},
    --         reportStyleChecksAsWarnings = false,
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
  zls = {
    type = "lsp",
    setup_lsp = function(lspconfig, defaults)
      lspconfig["zls"].setup(merge_tables(defaults, {
        on_attach = on_attach,
        filetypes = { "zig", "zir" },
        root_dir = lspconfig.util.root_pattern("zls.json", "build.zig", ".git"),
        single_file_support = true,
        settings = {
          zig_lib_path = "/opt/homebrew/Cellar/zig/0.15.1/lib/zig",
          enable_build_on_save = true
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
  ["eslint"] = {
    type = "lsp",
    setup_lsp = function(lspconfig, defaults)
      lspconfig["eslint"].setup(merge_tables(defaults, {
        -- TODO: make eslint work on InsertExit
        silent = true,
        settings = {
          eslint = {
            run = "onSave",
          },
        },
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
        end,
      }))
    end,
  },
}

bootstrap(config, on_attach)

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
