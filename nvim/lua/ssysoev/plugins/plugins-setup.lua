-- Ensure packer is install or automatically install it
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- plugins
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use
	use("lewis6991/impatient.nvim") -- several optimisations improving start up time
	use("https://gitlab.com/yorickpeterse/nvim-window.git") -- visual window switcher
	use("samjwill/nvim-unception") -- simplify opening files from within Neovim's terminal emulator

	-- startup screen
	use({ "goolord/alpha-nvim", requires = { "kyazdani42/nvim-web-devicons" } })

	-- theme
	use("Yazeed1s/oh-lucy.nvim")
	use({ "rose-pine/neovim", as = "rose-pine" })
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})
	use("EdenEast/nightfox.nvim")
	use({ "nyoom-engineering/oxocarbon.nvim" })

	-- icons
	use({
		"nvim-tree/nvim-tree.lua",
		tag = "nightly",
		cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
		config = function()
			require("ssysoev.plugins.nvim-tree")
		end,
	})

	-- vs-code like icons
	use("kyazdani42/nvim-web-devicons")

	-- status line
	use("nvim-lualine/lualine.nvim")

	-- quick editing / editing niceties
	use({ "tpope/vim-surround", keys = {
		{ "n", "cs" },
		{ "n", "ds" },
		{ "n", "ys" },
	} }) -- add, delete, change surroundings
	use({ "numToStr/Comment.nvim" }) -- commenting with gc
	use("folke/todo-comments.nvim") -- highlight and list todos
	use({
		"norcalli/nvim-colorizer.lua", -- highlight colors
		cmd = { "ColorizerToggle" },
		config = function()
			require("ssysoev.plugins.colorizer")
		end,
	})
	use({ "jghauser/mkdir.nvim" }) -- automatically create missing folders on file save

	-- fuzzy finder
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
	use("nvim-telescope/telescope-live-grep-args.nvim") -- enables passing arguments to the grep command
	use({
		"FeiyouG/command_center.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
	})

	-- completion
	use({
		{
			"hrsh7th/nvim-cmp",
			module = { "nvim-cmp", "cmp" },
			config = function()
				require("ssysoev.plugins.nvim-cmp")
			end,
			event = "InsertEnter *",
		},

		-- sources
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
		{ "hrsh7th/cmp-path", after = "nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
		{ "ray-x/cmp-treesitter", after = "nvim-cmp" },
		{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },

		-- snippets
		{ "L3MON4D3/LuaSnip", module = { "luasnip", "LuaSnip" } },
		{ "rafamadriz/friendly-snippets", after = "LuaSnip" },
	})

	-- lsp
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		cmd = { "Lspsaga" },
		config = function()
			require("ssysoev.plugins.lsp.lspsaga")
		end,
	}) -- enhanced lsp uis
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		cmd = { "Trouble" },
		config = function()
			require("ssysoev.plugins.lsp.trouble")
		end,
	}) -- list view for diagnostics
	use({
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline" },
		config = function()
			require("ssysoev.plugins.lsp.symbols-outline")
		end,
	})
	use({
		"dnlhc/glance.nvim",
		cmd = { "Glance" },
		config = function()
			require("glance").setup({
				border = {
					enable = true,
				},
				winbar = {
					enable = false,
				},
			})
		end,
	}) -- pretty ui for references / definitions / etc...vim
	use("marilari88/twoslash-queries.nvim") -- print typescript types as inline virtual text and dynamically update it

	-- linters & formatting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use("nvim-treesitter/nvim-treesitter-textobjects") -- additional text objects from treesitter
	use("JoosepAlviste/nvim-ts-context-commentstring") -- setting commentstring settings depending on cursor position in a file
	use("nvim-treesitter/nvim-treesitter-context") -- keeps current context visible e.g. function declaration, same as in vscode
	use({
		"mizlan/iswap.nvim",
		cmd = { "ISwap" },
		config = function()
			require("ssysoev.plugins.iswap")
		end,
	}) -- Interactively select and swap: function arguments, list elements, function parameters, and more.
	use("Dkendal/nvim-treeclimber") -- treesitter based navigation and selection

	-- auto closing
	use({ "windwp/nvim-autopairs" }) -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use({ "lewis6991/gitsigns.nvim" }) -- show line modifications on left hand side
	use({ "ruifm/gitlinker.nvim", requires = "nvim-lua/plenary.nvim" }) -- generates shareable link to a git repo, similar to open-in-github vscode plugin

	-- winbar, top panel with context like in vscode
	use({
		"utilyre/barbecue.nvim",
		commit = "91da47d44b70dd9cad05fe6831d0238fb971077f",
		requires = {
			"neovim/nvim-lspconfig",
			"smiteshp/nvim-navic",
			"kyazdani42/nvim-web-devicons",
		},
	})

	-- per project config
	use("gpanders/editorconfig.nvim") -- support .editorconfig files

	-- better yanking
	use({ "gbprod/yanky.nvim" })

	-- better quickfix list
	use("https://gitlab.com/yorickpeterse/nvim-pqf.git")

	-- better buffers delete
	use("kazhala/close-buffers.nvim")

	-- tabs
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = "nvim-tree/nvim-web-devicons",
	})

	-- scrollbar
	use("petertriho/nvim-scrollbar")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
