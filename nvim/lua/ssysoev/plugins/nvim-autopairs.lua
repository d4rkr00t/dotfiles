return {
  {
    -- autoclose parens, brackets, quotes, etc...
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- enable treesitter
      disable_filetype = { "TelescopePrompt" },
      ts_config = {
        lua = { "string" },               -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javascript template_string treesitter nodes
        java = false,                     -- don't check treesitter on java
      },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    }
  },

}
