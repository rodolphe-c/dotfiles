return {
  'Faywyn/llama-copilot.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    host = 'localhost',
    port = '11434',
    model = 'codellama:7b-code',
    max_completion_size = 15, -- use -1 for limitless
    debug = false,
  },
}
