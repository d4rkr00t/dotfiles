local M = {}

M.picker = function()
  local current_file = vim.api.nvim_buf_get_name(0)
  local query = table.concat(
    vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() }),
    " "
  )

  Snacks.picker.pick({
    title = "Pickaxe",
    live = true,
    search = query,
    finder = function(opts, ctx)
      local search = ctx.filter.search
      if not search or search == "" then return {} end

      return require("snacks.picker.source.proc").proc(
        ctx:opts({
          cmd = "git",
          args = {
            "log", "-i", "--abbrev-commit", "--date=short",
            "--pretty=format:%h %s (%cr) <%an>",
            "-G", search,
            "--", current_file,
          },
          notify = false,
          ---@param item snacks.picker.finder.Item
          transform = function(item)
            item.file = current_file
          end,
        }),
        ctx
      )
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
