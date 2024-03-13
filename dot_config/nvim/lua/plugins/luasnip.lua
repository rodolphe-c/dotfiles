return {
	'L3MON4D3/LuaSnip',
	enabled = true,
	dependencies = { 'rafamadriz/friendly-snippets' },
	config = function()
		require('luasnip.loaders.from_vscode').lazy_load()
		require('luasnip').filetype_extend('cpp', { 'cppdoc' })
	end
}
