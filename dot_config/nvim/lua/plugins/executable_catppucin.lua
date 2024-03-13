return {
	'catppuccin/nvim',
	enabled = true,
	cond = not vim.g.vscode,
	name = 'catppuccin',
	priority = 1000,
	config = function()
		require('catppuccin').setup({
			flavour = 'latte', -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = 'latte',
				dark = 'mocha',
			},
			transparent_background = true, -- disables setting the background color.
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			term_colors = false,  -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = false,  -- dims the background color of inactive window
				shade = 'dark',
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			no_italic = false,    -- Force no italic
			no_bold = false,      -- Force no bold
			no_underline = false, -- Force no underline
			styles = {            -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { 'italic' }, -- Change the style of comments
				conditionals = { 'italic' },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {},
			custom_highlights = {},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				harpoon = true,
				--notify = false,
				mini = true,
				indent_blankline = {
					enabled = true,
					scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
					colored_indent_levels = false,
				},
				mason = true,
				dap = {
					enabled = true,
					enable_ui = true, -- enable nvim-dap-ui
				},
				telescope = {
					enabled = true,
				}
				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
		})

		vim.cmd.colorscheme 'catppuccin'
	end
}