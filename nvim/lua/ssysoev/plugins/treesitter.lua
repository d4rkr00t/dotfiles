local safe_require = require("ssysoev.utils.safe-require")
safe_require({ "nvim-treesitter.configs" }, function(mods)
	local treesitter = mods["nvim-treesitter.configs"]

	-- configure treesitter
	treesitter.setup({
		-- enable syntax highlighting
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
			disable = {},
		},
		-- enable indentation
		indent = {
			enable = true,
		},
		-- enable autotagging (w/ nvim-ts-autotag plugin)
		autotag = {
			enable = true,
			filetypes = {
				"html",
				"xml",
				"javascript",
				"javascriptreact",
				"typescriptreact",
				"svelte",
				"vue",
			},
		},
		-- ensure these language parsers are installed
		ensure_installed = {
			"bash",
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"markdown",
			"svelte",
			"graphql",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"go",
			"rust",
			"python",
			"swift",
		},
		-- auto install above language parsers
		auto_install = true,

		incremental_selection = {
			enable = false,
			keymaps = {},
		},

		textobjects = {
			select = {
				enable = true,
				lookahead = true,

				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
				},
			},

			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
				},
			},
		},

		context_commentstring = {
			enable = true,
		},
	})
end)
