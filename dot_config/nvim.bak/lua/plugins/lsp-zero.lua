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
		{ "folke/lazydev.nvim" },
		{ 'jay-babu/mason-nvim-dap.nvim' },
		{ 'mfussenegger/nvim-dap' },
		{ 'nvim-neotest/nvim-nio' },
		{ 'rcarriga/nvim-dap-ui' },
		{ 'mfussenegger/nvim-dap-python' },
		{ 'theHamsta/nvim-dap-virtual-text' },
	},
	config = function()
		-- LSP
		require('lazydev').setup()
		require('mason').setup()

		local lsp_zero = require('lsp-zero')

		lsp_zero.on_attach(function(_, bufnr)
			lsp_zero.default_keymaps({ buffer = bufnr })
			vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })

			vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
			vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { buffer = bufnr })
			vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { buffer = bufnr })
			vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, { buffer = bufnr })
			vim.keymap.set('n', '<leader>go', vim.lsp.buf.type_definition, { buffer = bufnr })
			vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, { buffer = bufnr })
			vim.keymap.set('n', '<leader>gs', vim.lsp.buf.signature_help, { buffer = bufnr })
			vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { buffer = bufnr })
			vim.keymap.set({ 'n', 'x' }, '<F3>', vim.lsp.buf.format, { buffer = bufnr })
			vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, { buffer = bufnr })
			vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { buffer = bufnr })
			vim.keymap.set('n', '[d', vim.diagnostic.get_prev, { buffer = bufnr })
			vim.keymap.set('n', ']d', vim.diagnostic.get_next, { buffer = bufnr })
		end)


		require('mason-lspconfig').setup({
			ensure_installed = {
				'bashls',
				'glsl_analyzer',
				'lua_ls',
				'marksman',
				'opencl_ls',
				'pyright',
				'rust_analyzer',
				'tsserver',
				'yamlls',
			},
			handlers = {
				lsp_zero.default_setup,
			},
		})

		-- here you can setup the language servers
		local lspconfig = require('lspconfig')

		lspconfig.clangd.setup({
			cmd = { "clangd", "--background-index" },
			settings = {
				clangd = {
					completion = {
						callSnippet = "Replace",
					}
				}
			}
		})
		lspconfig.bashls.setup({})
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
				},
			}
		})
		lspconfig.marksman.setup({})
		lspconfig.pyright.setup({})
		lspconfig.rust_analyzer.setup({})
		lspconfig.tsserver.setup({})
		lspconfig.yamlls.setup({})

		vim.keymap.set('n', '<leader>cs', vim.cmd.ClangdSwitchSourceHeader, {})

		require('mason-nvim-dap').setup({
			ensure_installed = {
				'codelldb',
				'python',
			},
			automatic_installation = true,
		})

		local dap, dapui = require('dap'), require('dapui')
		dapui.setup()

		vim.keymap.set('n', '<F5>', dap.continue, {})
		vim.keymap.set('n', '<F10>', dap.step_over, {})
		vim.keymap.set('n', '<F11>', dap.step_into, {})
		vim.keymap.set('n', '<F12>', dap.step_out, {})

		vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, {})
		vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, {})
		vim.keymap.set('n', '<leader>dl', dap.run_last, {})
		vim.keymap.set('n', '<leader>dc', dap.continue, {})
		vim.keymap.set('n', '<leader>dr', dap.repl.open, {})
		vim.keymap.set('n', '<leader>ds', dap.stop, {})
		vim.keymap.set('n', '<leader>de', dapui.eval, {})

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		local mason_registry = require('mason-registry')
		local codelldb_path = mason_registry.get_package("codelldb"):get_install_path() .. '/codelldb'
		dap.adapters.codelldb = {
			type = 'server',
			port = "${port}",
			executable = {
				-- CHANGE THIS to your path!
				command = codelldb_path,
				args = { "--port", "${port}" },
				-- On windows you may have to uncomment this:
				-- detached = false,
			}
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				args = function()
					local input = vim.fn.input('Input arguments: ')
					if input ~= '' then
						return vim.split(input, ' ')
					end
					return {}
				end,
				cwd = '${workspaceFolder}',
				stopOnEntry = false,
			},
		}

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		require('dap-python').setup('python')
	end
}
