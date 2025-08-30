local M = {}

M.spec = {
  'lewis6991/gitsigns.nvim',
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },

  opts = {
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signs_staged = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signs_staged_enable = true,
    signcolumn = true,
    numhl = false,
    linehl = true,
    word_diff = false,
    watch_gitdir = {
      follow_files = true,
    },
  },

  keys = {
    {
      '<leader>gb',
      function()
        vim.schedule(function()
          require('gitsigns').blame_line { full = true }
        end)
      end,
      desc = 'Blame Line',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gx',
      function()
        require('gitsigns').toggle_current_line_blame()
      end,
      desc = 'Toggle Current Line Blame',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gB',
      function()
        require('gitsigns').blame()
      end,
      desc = 'Blame Buffer',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gl',
      function()
        require('gitsigns').toggle_linehl()
      end,
      desc = 'Toggle Line Highlight',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gn',
      function()
        require('gitsigns').toggle_numhl()
      end,
      desc = 'Toggle Number Highlight',
      buffer = true,
      noremap = true,
      silent = true,
    },
  },
}

return M.spec
