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

	-- icons
	use("nvim-tree/nvim-tree.lua")

	-- vs-code like icons
	use("kyazdani42/nvim-web-devicons")

	-- status line
	use("nvim-lualine/lualine.nvim")

	-- quick editing / editing niceties
	use("tpope/vim-surround") -- add, delete, change surroundings
	use("numToStr/Comment.nvim") -- commenting with gc
	use("folke/todo-comments.nvim") -- highlight and list todos

	-- fuzzy finder
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
	use("nvim-telescope/telescope-live-grep-args.nvim") -- enables passing arguments to the grep command
	use({
		"FeiyouG/command_center.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
	})

	-- completion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths
	use("hrsh7th/cmp-nvim-lsp-signature-help") -- source for function signature completion
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion from lsp servers
	use({ "David-Kunz/cmp-npm", requires = { "nvim-lua/plenary.nvim" } }) -- allows to autocomplete npm packages and its versions

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- lsp
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
	use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" }) -- list view for diagnostics
	use({ "simrat39/symbols-outline.nvim" })

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
	use("mizlan/iswap.nvim") -- Interactively select and swap: function arguments, list elements, function parameters, and more.
	use("Dkendal/nvim-treeclimber") -- treesitter based navigation and selection

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
	use({ "ruifm/gitlinker.nvim", requires = "nvim-lua/plenary.nvim" }) -- generates shareable link to a git repo, similar to open-in-github vscode plugin

	-- winbar, top panel with context like in vscode
	use({
		"utilyre/barbecue.nvim",
		requires = {
			"neovim/nvim-lspconfig",
			"smiteshp/nvim-navic",
			"kyazdani42/nvim-web-devicons",
		},
	})

	-- per project config
	use("gpanders/editorconfig.nvim") -- support .editorconfig files

	-- better yanking
	use("gbprod/yanky.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
