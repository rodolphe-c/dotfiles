return {
	'VonHeikemen/lsp-zero.nvim',
	enabled = true,
	branch = 'v3.x',
	dependencies = {
		-- LSP Support
		{ 'neovim/nvim-lspconfig' },
		{ 'williamboman/mason.nvim' },
		{ 'williamboman/mason-lspconfig.nvim' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/nvim-cmp' },
		{ 'L3MON4D3/LuaSnip' },
		{ "folke/neodev.nvim",                opts = {} },
	},
	config = function()
		-- LSP
		require("neodev").setup({
			library = { plugins = { "nvim-dap-ui" }, types = true },
		})


		local lsp_zero = require('lsp-zero')

		lsp_zero.on_attach(function(client, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			lsp_zero.default_keymaps({ buffer = bufnr })
			vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
		end)

		-- to learn how to use mason.nvim with lsp-zero
		-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
		require('mason-lspconfig').setup({
			ensure_installed = {
				'bashls',
				'clangd',
				'glsl_analyzer',
				'lua_ls',
				'marksman',
				'opencl_ls',
				'pyright',
				-- 'pylyzer',
				'rust_analyzer',
				'tsserver',
				'yamlls',
			},
			handlers = {
				lsp_zero.default_setup,
			},
		})
		-- here you can setup the language servers
	end
}
