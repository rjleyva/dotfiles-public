return {
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
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },

  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)

    wk.add {
      { '<leader>w', group = 'Window Managment' },
      { '<leader>/', group = 'Tab Management' },
      { '<leader>e', group = 'Neo Tree Explorer' },
      { '<leader>f', group = 'Fuzzy Finder' },
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Dadbod' },
      { '<leader>l', group = 'LSP Actions' },
      { '<leader>x', group = 'Diagnostics' },
      { '<leader>g', group = 'Git' },
      { '<leader>r', group = 'Refactoring' },
      { '<leader>n', group = 'Noice' },
      { '<leader>t', group = 'Test Runner (Neotest)' },
      { '<leader>;', group = 'Debug (DAP)' },
      { '<leader>?', group = 'Buffer Local Keys' },
    }
  end,
}
