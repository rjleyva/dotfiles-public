return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = { 'Neotree' },
  dependencies = {
    {
      'nvim-lua/plenary.nvim',
      lazy = true,
    },
    {
      'nvim-tree/nvim-web-devicons',
      lazy = true,
    },
    {
      'MunifTanjim/nui.nvim',
      lazy = true,
    },
  },

  opts = {
    sources = { 'filesystem', 'buffers', 'git_status' },
    open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
    filesystem = {
      window = { position = 'right' },
    },
    buffers = {
      window = { position = 'right' },
    },
    git_status = {
      window = { position = 'right' },
    },
  },

  keys = {
    {
      '<leader>ee',
      '<cmd>Neotree toggle<cr>',
      desc = 'Toggle Neo-tree sidebar',
    },
    {
      '<leader>ec',
      function()
        local reveal_file = vim.fn.expand '%:p'
        if reveal_file == '' or vim.loop.fs_stat(reveal_file) == nil then
          reveal_file = vim.fn.getcwd()
        end

        require('neo-tree.command').execute {
          action = 'focus',
          source = 'filesystem',
          position = 'right',
          reveal_file = reveal_file,
          reveal_force_cwd = true,
        }
      end,
      desc = 'Reveal current file in Neo-tree',
    },
  },

  config = function(_, opts)
    require('neo-tree').setup(opts)
    vim.api.nvim_set_hl(0, 'NeoTreeRootName', { bold = true, italic = false })
  end,
}
