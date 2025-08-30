local M = {}

M.spec = {
  'tpope/vim-dadbod',
  ft = { 'sql', 'mysql', 'plsql', 'graphql' },

  dependencies = {
    {
      'kristijanhusak/vim-dadbod-ui',
      version = '*',
      cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
      },
      keys = {
        {
          '<leader>;l',
          '<cmd>DBUI<cr>',
          desc = 'Launch Database UI Explorer',
        },
        { '<leader>;t', '<cmd>DBUIToggle<cr>', desc = 'Toggle Database UI' },
        {
          '<leader>;a',
          '<cmd>DBUIAddConnection<cr>',
          desc = 'Add DB connection',
        },
        {
          '<leader>;s',
          '<cmd>DBUIFindBuffer<cr>',
          desc = 'Search DB buffer',
        },
      },
      init = function()
        vim.g.db_ui_use_nerd_fonts = 1
      end,
    },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'plsql', 'graphql' },
    },
  },
}

return M.spec
