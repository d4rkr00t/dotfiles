return {
  -- better text-objects
  {
    "nvim-mini/mini.ai",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
    },
    config = function()
      local ai = require("mini.ai")
      ai.setup( --
        {
          n_lines = 500,
          custom_textobjects = {
            o = ai.gen_spec.treesitter({
              a = { "@block.outer", "@conditional.outer", "@loop.outer" },
              i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            }, {}),
            f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
            c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
            t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
            d = { "%f[%d]%d+" }, -- digits
            e = {        -- Word with case
              {
                "%u[%l%d]+%f[^%l%d]",
                "%f[%S][%l%d]+%f[^%l%d]",
                "%f[%P][%l%d]+%f[^%l%d]",
                "^[%l%d]+%f[^%l%d]",
              },
              "^().*()$",
            },
            u = ai.gen_spec.function_call(),                   -- u for "Usage"
            U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
          },
        }
      )
    end,
  }
}
