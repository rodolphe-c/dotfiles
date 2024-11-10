return {
	'lewis6991/gitsigns.nvim',
	enabled = true,
	config = function()
		require('gitsigns').setup({
			signcolumn = true,
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
				delay = 500,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
			current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
		})
		-- set statusline+=%{get(b:,'gitsigns_status','')}
	end
}
