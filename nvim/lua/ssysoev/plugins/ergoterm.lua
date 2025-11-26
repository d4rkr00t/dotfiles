return {
  {
    "waiting-for-dev/ergoterm.nvim",
    keys = { "<leader>al" },
    config = function()
      local ergoterm = require("ergoterm")

      ergoterm.setup({
        terminal_defaults = {
          layout = "right",
        }
      })

      local ai_chats = ergoterm.with_defaults({
        auto_list = false,
        bang_target = false,
        sticky = true,
        watch_files = true,
        tags = { "ai_chat" }
      })

      local cc = require("ssysoev.custom.commander")

      ai_chats:new({
        cmd = "acli rovodev",
        name = "Rovo Dev",
        meta = {
          add_file = function(file)
            return "#" .. file
          end,
          add_file_context = function(file, context)
            return "#" .. file .. " | " .. context
          end
        }
      })

      ai_chats:new({
        cmd = "opencode",
        name = "Opencode",
        meta = {
          add_file = function(file)
            return "@" .. file
          end,
          add_file_context = function(file, context)
            return "@" .. file .. " | " .. context
          end
        }
      })

      local chats = ergoterm.filter_by_tag("ai_chat")

      cc.add({
        {
          desc = "Select AI Chat to Open",
          cmd = function()
            ergoterm.select({
              terminals = chats,
              propmpt = "Select AI Chat to Open"
            })
          end,
          keys = {
            "n", "<leader>al"
          }
        },
        {
          desc = "Add file to chat",
          cmd = function()
            ergoterm.select_started({
              terminals = chats,
              propmpt = "Add file to chat",
              callbacks = function(term)
                local file = vim.fn.expand("%:p")
                term:send({ term.meta.add_file(file) }, { new_line = false })
              end
            })
          end,
          keys = {
            "n", "<leader>aa"
          }
        },
        {
          desc = "Send visual selection to chat with context",
          cmd = function()
            ergoterm.select_started({
              terminals = chats,
              propmpt = "Send to chat",
              callbacks = function(term)
                local file = vim.fn.expand("%:p")
                local start_line = vim.fn.getpos(".")
                local end_line = vim.fn.getpos("v")
                local lines = table.concat(vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos(".")), "\n");
                local file_path_with_loc = string.format("%s:%d-%d", file, start_line[2], end_line[2])
                return term:send({ term.meta.add_file_context(file_path_with_loc, lines) }, { new_line = false })
              end
            })
          end,
          keys = {
            "v", "<leader>as"
          }
        },
        {
          desc = "Send to chat",
          cmd = function()
            ergoterm.select_started({
              terminals = chats,
              propmpt = "Send to chat",
              callbacks = function(term)
                local file = vim.fn.expand("%:p")
                local line = vim.fn.line(".")
                local file_path_with_loc = string.format("%s:%d", file, line)
                return term:send({ term.meta.add_file(file_path_with_loc) }, { new_line = false })
              end
            })
          end,
          keys = {
            "n", "<leader>as"
          }
        },
      })
    end
  }
}
