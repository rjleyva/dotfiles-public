return {
  'm4xshen/hardtime.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    disabled_filetypes = {
      'neo-tree',
      'lazy',
      'mason',
      'toggleterm',
      'qf',
      'help',
    },
    max_count = 3,
    hint = true,
    restriction_mode = 'hint',
    disable_mouse = true,
  },
}
