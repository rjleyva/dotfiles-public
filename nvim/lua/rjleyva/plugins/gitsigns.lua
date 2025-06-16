return {
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
    linehl = false,
    word_diff = true,
    watch_gitdir = {
      follow_files = true,
    },
  },

  keys = {
    {
      '<leader>g]',
      function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          require('gitsigns').nav_hunk 'next'
        end
      end,
      desc = 'Next Hunk',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>g[',
      function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          require('gitsigns').nav_hunk 'prev'
        end
      end,
      desc = 'Prev Hunk',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<ledaer>gL',
      function()
        require('gitsigns').nav_hunk 'last'
      end,
      desc = 'Last Hunk',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gF',
      function()
        require('gitsigns').nav_hunk 'first'
      end,
      desc = 'First Hunk',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gs',
      ':Gitsigns stage_hunk<CR>',
      mode = { 'n', 'v' },
      desc = 'Stage Hunk',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gr',
      ':Gitsigns reset_hunk<CR>',
      mode = { 'n', 'v' },
      desc = 'Reset Hunk',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gt',
      function()
        require('gitsigns').stage_buffer()
      end,
      desc = 'Stage Buffer',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gu',
      function()
        require('gitsigns').reset_hunk { to_index = true }
      end,
      desc = 'Undo Stage Hunk',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gR',
      function()
        require('gitsigns').reset_buffer()
      end,
      desc = 'Reset Buffer',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gp',
      function()
        require('gitsigns').preview_hunk_inline()
      end,
      desc = 'Preview Hunk Inline',
      buffer = true,
      noremap = true,
      silent = true,
    },
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
      '<leader>gd',
      function()
        require('gitsigns').diffthis()
      end,
      desc = 'Diff This',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gD',
      function()
        require('gitsigns').diffthis '~'
      end,
      desc = 'Diff This ~',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>g$',
      function()
        require('gitsigns').toggle_signs()
      end,
      desc = 'Toggle GitSigns',
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
    {
      '<leader>gb',
      function()
        require('gitsigns').toggle_current_line_blame()
      end,
      desc = 'Toggle Current Line Blame',
      buffer = true,
      noremap = true,
      silent = true,
    },
    {
      '<leader>gS',
      ':<C-U>Gitsigns select_hunk<CR>',
      mode = { 'o', 'x' },
      desc = 'Select Hunk',
      buffer = true,
      noremap = true,
      silent = true,
    },
  },
}
