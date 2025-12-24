local M = {}

M.picker = function()
  local fzf = require("fzf-lua")
  local query = require("fzf-lua.utils").get_visual_selection()
  local current_file = vim.api.nvim_buf_get_name(0)

  fzf.fzf_live(
    'git log -i --abbrev-commit --date=short --pretty="format:%C(yellow)%h%Creset %s %C(green)(%cr)%Creset %C(blue)<%an>%Creset" -G <query>' ..
    ' -- ' .. current_file,
    {
      query = query,
      prompt = "Pickaxe> ",
      actions = {
        ['default'] = function(selected)
          local clean_text = selected[1]:gsub("\27%[[0-9;]*m", "")
          local current_commit = clean_text:match("^%S+")
          if not current_commit then
            print("Error! Hash not found in selected item")
            return
          end

          local parent_commit = vim.trim(vim.fn.system("git rev-parse --short " .. current_commit .. "^"))
          parent_commit = parent_commit:match("[a-f0-9]+")

          if vim.v.shell_error ~= 0 then
            vim.notify("Cannot find parent (Root commit?)", vim.log.levels.WARN)
            parent_commit = ""
          end

          vim.notify("Diffing: " .. parent_commit .. " -> " .. current_commit)
          vim.cmd("CodeDiff " .. parent_commit .. " " .. current_commit)
        end,
      }
    }
  )
end

return M
