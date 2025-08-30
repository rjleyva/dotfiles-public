local M = {}

M.spec = {
  'ThePrimeagen/refactoring.nvim',
  version = '*',
  ft = {
    'astro',
    'svelte',
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact',
    'tsx',
    'jsx',
    'go',
    'python',
  },

  dependencies = {
    { 'nvim-treesitter/nvim-treesitter', optional = true },
  },

  opts = {
    prompt_func_return_type = {
      go = true,
      python = true,
    },
    print_var_statements = {
      lua = { 'print' },
      javascript = { 'console.log' },
      javascriptreact = { 'console.log' },
      typescript = { 'console.log' },
      typescriptreact = { 'console.log' },
      tsx = { 'console.log' },
      jsx = { 'console.log' },
      svelte = { 'console.log' },
      astro = { 'console.log' },
      python = { 'print' },
      go = { 'fmt.Println' },
    },
  },

  config = function(_, opts)
    require('refactoring').setup(opts)
  end,

  keys = {
    {
      '<leader>r',
      function()
        require('refactoring').select_refactor {
          show_success_message = true,
        }
      end,
      mode = 'v',
      desc = 'Refactor',
    },
  },
}

return M.spec
