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
	},
	config = function()
		-- LSP
		require('mason').setup()
		local lsp_zero = require('lsp-zero')

		lsp_zero.on_attach(function(_, bufnr)
			lsp_zero.default_keymaps({ buffer = bufnr })
			vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
		end)

		require('mason-lspconfig').setup({
			handlers = {
				lsp_zero.default_setup,
			},
		})
	end
}
