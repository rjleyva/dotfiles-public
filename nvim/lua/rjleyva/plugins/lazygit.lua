return {
  'kdheepak/lazygit.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = { 'LazyGit' },
  keys = {
    {
      '<leader>gg',
      '<cmd>LazyGit<cr>',
      desc = 'Open LazyGit',
    },
  },
}
