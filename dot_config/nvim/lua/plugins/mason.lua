return {
	'williamboman/mason.nvim',
	enabled = true,
	config = function()
		require('mason').setup()
	end
}
