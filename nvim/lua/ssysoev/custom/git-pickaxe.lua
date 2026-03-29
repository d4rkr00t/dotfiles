local get_visual_selection_text = require("ssysoev.utils.get-selected-text")

local M = {}

M.picker = function()
  local current_file = vim.api.nvim_buf_get_name(0)
  local query = table.concat(get_visual_selection_text(), " ")

  Snacks.picker.pick({
    title = "Pickaxe",
    live = true,
    search = query,
    finder = function(opts, ctx)
      local search = ctx.filter.search
      if not search or search == "" then return {} end

      local output = vim.fn.systemlist({
        "git", "log", "-i", "--abbrev-commit", "--date=short",
        "--pretty=format:%h %s (%cr) <%an>",
        "-G", search,
        "--", current_file,
      })

      local items = {}
      for i, line in ipairs(output) do
        if line ~= "" then
          table.insert(items, { idx = i, text = line, file = current_file })
        end
      end
      return items
    end,
    format = function(item)
      return {
        { item.text, "Normal" },
      }
    end,
    confirm = function(picker, item)
      picker:close()
      if not item then return end

      local clean = item.text:gsub("\27%[[0-9;]*m", "")
      local commit = clean:match("^%S+")
      if not commit then
        print("Error! Hash not found in selected item")
        return
      end

      local parent = vim.trim(vim.fn.system("git rev-parse --short " .. commit .. "^"))
      parent = parent:match("[a-f0-9]+")

      if vim.v.shell_error ~= 0 then
        vim.notify("Cannot find parent (Root commit?)", vim.log.levels.WARN)
        parent = ""
      end

      vim.notify("Diffing: " .. parent .. " -> " .. commit)
      vim.cmd("CodeDiff " .. parent .. " " .. commit)
    end,
  })
end

return M
