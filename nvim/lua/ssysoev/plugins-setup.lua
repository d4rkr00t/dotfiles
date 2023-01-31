return {
	-- lua functions that many plugins use
	"nvim-lua/plenary.nvim",

	--
	-- file tree
	--
	{
		"nvim-tree/nvim-tree.lua",
		tag = "nightly",
		cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
		config = function()
			require("ssysoev.plugins.nvim-tree")
		end,
	},

	--
	-- UI niceties
	--

	-- colorscheme
	{ "EdenEast/nightfox.nvim", lazy = true },
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "nyoom-engineering/oxocarbon.nvim", lazy = true },

	{
		-- better quickfix list
		url = "https://gitlab.com/yorickpeterse/nvim-pqf.git",
		event = "VeryLazy",
		config = function()
			require("ssysoev.plugins.nvim-pqf")
		end,
	},

	{
		-- tabs
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		tag = "v3.1.0",
		config = function()
			require("ssysoev.plugins.bufferline")
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		-- scrollbar
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
		config = function()
			require("ssysoev.plugins.scrollbar")
		end,
	},

	-- icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		-- vs-code like icons for autocompletion
		"onsails/lspkind.nvim",
		event = "VeryLazy",
		config = function()
			require("ssysoev.plugins.lspkind")
		end,
	},

	{
		-- status line
		"nvim-lualine/lualine.nvim",
		config = function()
			require("ssysoev.plugins.lualine")
		end,
	},

	{
		--  indentation guides to all lines
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ssysoev.plugins.indent-blankline")
		end,
	},

	{
		-- extra nice uis for popup menus / inputs / etc
		"folke/noice.nvim",
		config = function()
			require("ssysoev.plugins.noice")
		end,
		dependencies = { "MunifTanjim/nui.nvim" },
	},

	-- better vim.ui
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			require("ssysoev.plugins.dressing")
		end,
	},

	--
	-- fuzzy finder
	--
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			-- dependency for better sorting performance
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- enables passing arguments to the grep command
			"nvim-telescope/telescope-live-grep-args.nvim",
			-- keymaps util and help
			"FeiyouG/command_center.nvim",
			{
				"danielfalk/smart-open.nvim",
				dependencies = { "tami5/sqlite.lua" },
			},
		},
		config = function()
			require("ssysoev.plugins.telescope")
		end,
	},

	--
	-- quick editing / editing niceties
	--
	{
		-- add, delete, change surroundings
		"tpope/vim-surround",
		keys = { "cs", "ds", "ys" },
	},

	{
		-- commenting with gc
		"echasnovski/mini.comment",
		event = "VeryLazy",
		config = function()
			require("ssysoev.plugins.comment")
		end,
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},

	{
		-- highlight colors
		"norcalli/nvim-colorizer.lua",
		cmd = { "ColorizerToggle" },
		config = function()
			require("ssysoev.plugins.colorizer")
		end,
	},

	-- automatically create missing folders on file save
	{ "jghauser/mkdir.nvim" },

	-- better text-objects
	{
		"echasnovski/mini.ai",
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
			require("ssysoev.plugins.mini-ai")
		end,
	},

	--
	-- copilot
	--
	{
		"zbirenbaum/copilot.lua",
		cmd = { "Copilot" },
		event = "InsertEnter",
		config = function()
			vim.schedule(function()
				require("ssysoev.plugins.copilot")
			end)
		end,
	},

	--
	-- completion
	--
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("ssysoev.plugins.nvim-cmp")
		end,
		event = "InsertEnter",
		dependencies = {
			-- sources
			"hrsh7th/cmp-buffer",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},

			-- snippets
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
			},
		},
	},

	--
	-- lsp
	--
	{
		-- in charge of managing lsp servers, linters & formatters
		"williamboman/mason.nvim",
		event = { "VeryLazy" },
		config = function()
			require("ssysoev.plugins.lsp.init")
		end,
		dependencies = {
			-- bridges gap b/w mason & lspconfig
			"williamboman/mason-lspconfig.nvim",

			-- easily configure language servers
			"neovim/nvim-lspconfig",

			-- additional functionality for typescript server (e.g. rename file & update imports)
			"jose-elias-alvarez/typescript.nvim",

			-- configure formatters & linters
			"jose-elias-alvarez/null-ls.nvim",

			-- bridges gap b/w mason & null-ls
			"jayp0521/mason-null-ls.nvim",

			{
				"glepnir/lspsaga.nvim",
				event = "BufRead",
				config = function()
					require("ssysoev.plugins.lsp.lspsaga")
				end,
				dependencies = { { "nvim-tree/nvim-web-devicons" } },
			},
		},
	},

	{
		-- list view for diagnostics
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		cmd = { "Trouble" },
		config = function()
			require("ssysoev.plugins.lsp.trouble")
		end,
	},

	{
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline" },
		config = function()
			require("ssysoev.plugins.lsp.symbols-outline")
		end,
	},

	-- print typescript types as inline virtual text and dynamically update it
	{
		"marilari88/twoslash-queries.nvim",
		lazy = true,
		config = function()
			require("ssysoev.plugins.twoslash")
		end,
	},

	--
	--
	-- Treesitter
	--
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("ssysoev.plugins.treesitter")
		end,
	},

	{
		-- keeps current context visible e.g. function declaration, same as in vscode
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("ssysoev.plugins.treesitter-context")
		end,
	},

	{
		-- treesitter based navigation and selection
		"Dkendal/nvim-treeclimber",
		config = function()
			require("ssysoev.plugins.nvim-treeclimber")
		end,
	},

	"nvim-treesitter/playground",

	--
	-- auto closing
	--
	{
		-- autoclose parens, brackets, quotes, etc...
		"windwp/nvim-autopairs",
		config = function()
			require("ssysoev.plugins.autopairs")
		end,
	},

	{
		-- autoclose tags
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	--
	-- git integration
	--
	{
		-- show line modifications on left hand side
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("ssysoev.plugins.gitsigns")
		end,
	},

	{
		-- generates shareable link to a git repo, similar to open-in-github vscode plugin
		"d4rkr00t/gitlinker.nvim",
		event = "VeryLazy",
		branch = "timeout",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("ssysoev.plugins.gitlinker")
		end,
	},

	-- visual window switcher
	{
		url = "https://gitlab.com/yorickpeterse/nvim-window.git",
		event = "VeryLazy",
		config = function()
			require("ssysoev.plugins.nvim-window")
		end,
	},

	--
	-- per project config
	--

	-- support .editorconfig files
	"gpanders/editorconfig.nvim",

	--
	-- Other
	--

	-- improved terminal support
	{
		"samjwill/nvim-unception",
		event = "VeryLazy",
	},
}
