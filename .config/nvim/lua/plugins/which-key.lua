local M = {}

M.spec = {
  'folke/which-key.nvim',
  version = '*',
  event = 'VeryLazy',

  opts = {
    plugins = {
      spelling = { enabled = false },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    win = {
      border = 'rounded',
    },
    layout = {
      align = 'center',
    },
  },

  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer local keymaps (which-Key)',
    },
  },

  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)

    wk.add {
      { '<leader>f', group = 'Fuzzy Finder' },
      { '<leader>c', group = 'Code' },
      { '<leader>;', group = 'Dadbod' },
      { '<leader>d', group = 'Dap' },
      { '<leader>L', group = 'Lint' },
      { '<leader>x', group = 'Diagnostics' },
      { '<leader>g', group = 'Git' },
      { '<leader>r', group = 'Refactoring' },
      { '<leader>q', group = 'Quickfix' },
      { 'gr', group = 'LSP Actions' },
    }
  end,
}

return M.spec
