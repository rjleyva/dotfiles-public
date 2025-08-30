local M = {}

M.spec = {
  'kdheepak/lazygit.nvim',
  cmd = { 'LazyGit' },

  keys = {
    {
      '<leader>gg',
      '<cmd>LazyGit<cr>',
      desc = 'Open LazyGit',
    },
  },
}

return M.spec
