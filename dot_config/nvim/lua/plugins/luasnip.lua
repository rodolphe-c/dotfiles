return {
	'L3MON4D3/LuaSnip',
	enabled = true,
	cond = not vim.g.vscode,
	dependencies = { 'rafamadriz/friendly-snippets' },
	build = "make install_jsregexp",
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip").filetype_extend("cpp", { "cppdoc" })
	end
}
