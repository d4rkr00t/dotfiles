-- rg globs for stuff that is almost never what you are grepping for.
-- Each group is toggled independently in the grep/file pickers: T / N.
local exclude_groups = {
  -- T -- tests, fixtures, snapshots
  no_tests = {
    -- test directories
    "**/__tests__/**",
    "**/__test__/**",
    "**/__mocks__/**",
    "**/__snapshots__/**",
    "**/test/**",
    "**/tests/**",
    "**/spec/**",
    "**/specs/**",
    "**/e2e/**",
    "**/*-test/**",
    "**/*-tests/**", -- vr-tests, integration-tests, editor-core-tests, ...
    "**/test-utils/**",
    "**/testdata/**",
    "**/fixtures/**",
    -- test files: foo.test.tsx, foo-test.ts, foo_test.go, foo.specs.ts, ...
    "**/*[._-]test.*",
    "**/*[._-]tests.*",
    "**/*[._-]spec.*",
    "**/*[._-]specs.*",
    "**/*.vr.*", -- visual regression
    "**/*.e2e.*",
    "**/*.integration.*",
    "**/*.unit.*",
    "**/*test-utils.*",
    "**/*.snap",
  },
  -- N -- vendored, generated, build output and churn
  no_noise = {
    "**/.yarn/**",
    "**/.git-hooks/**",
    "**/.afm-cache/**",
    "**/.prebuilt/**",
    "**/dist/**",
    "**/build/**",
    "**/coverage/**",
    "**/__generated__/**",
    "**/*.graphql.ts", -- relay artifacts
    "**/declaration.d.ts",
    "**/*.min.js",
    "**/*.map",
    "**/CHANGELOG.md",
    "**/*.patch",
    "**/*.log",
  },
}

-- Which groups are active, per source. Toggling in the picker updates this, so
-- the next open reuses the same filters. Session only; resets on restart.
local excluding = {
  grep = { no_tests = true, no_noise = true },
  smart = { no_noise = true },
}

-- applied on every open, so the picker starts from the remembered state
local function apply_excluding(opts)
  local state = excluding[opts.source]
  opts.exclude = {}
  for group, globs in pairs(exclude_groups) do
    opts[group] = state[group]
    if state[group] then
      vim.list_extend(opts.exclude, globs)
    end
  end
  return opts
end

-- action that flips one group, remembers it, and re-runs the finder
local function toggle_group(group)
  return function(picker)
    local state = excluding[picker.opts.source]
    state[group] = not state[group]
    apply_excluding(picker.opts)
    picker.list:set_target()
    picker:find()
  end
end

local toggle_keys = {
  input = {
    keys = {
      ["<a-t>"] = { "toggle_tests", mode = { "i", "n" } },
      ["<a-n>"] = { "toggle_noise", mode = { "i", "n" } },
    },
  },
}

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = {
        enabled = true,
        size = 1 * 1024 * 1024,
        notify = true,
      },
      gitbrowse = {
        enabled = true,
        url_patterns = {
          ["bitbucket%.org"] = {
            branch = "/src/{branch}",
            file = "/src/{branch}/{file}#lines-{line_start}:{line_end}",
            permalink = "/src/{commit}/{file}#lines-{line_start}:{line_end}",
            commit = "/commits/{commit}",
          },
        }
      },
      input = { enabled = true },
      picker = {
        enabled = true,
        ui_select = true,
        hidden = true,
        matcher = {
          frecency = true,
          history_bonus = true,
        },
        sources = {
          -- file search skips noise but keeps tests by default
          smart = {
            matcher = {
              sort_empty = false,
            },
            multi = { { source = "buffers", current = false }, "recent", "files" },
            config = apply_excluding,
            win = toggle_keys,
          },
          -- grep skips tests + noise by default; <a-t> / <a-n> toggle them
          -- back in, and the choice sticks for the rest of the session
          grep = {
            config = apply_excluding,
            win = toggle_keys,
          },
        },
        -- "T" / "N" in the picker title while that group is excluded
        toggles = { no_tests = "T", no_noise = "N" },
        actions = {
          toggle_tests = toggle_group("no_tests"),
          toggle_noise = toggle_group("no_noise"),
        },
        layout = {
          preset = "bottom",
          layout = {
            height = 0.5
          }
        },
      },
      quickfile = { enabled = true },
      statuscolumn = {
        enabled = true,
        folds = {
          open = true
        }
      }
    },
  },
}
