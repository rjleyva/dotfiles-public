return {
  'ibhagwan/fzf-lua',
  enabled = true,
  lazy = true,
  cmd = { 'FzfLua' },
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', lazy = true },
  },
  opts = {
    file_icon_padding = '',
    keymap = {
      fzf = {
        ['CTRL-Q'] = 'select-all+accept',
      },
    },
    fzf_opts = {
      ['--wrap'] = true,
    },
    winopts = {
      preview = {
        wrap = 'wrap',
      },
      formatter = 'path.filename_first',
    },
  },

  keys = {
    {
      '<leader>fs',
      function()
        require('fzf-lua').commands()
      end,
      desc = 'Search Neovim commands',
    },
    {
      '<leader>ff',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Find files',
    },
    {
      '<leader>fh',
      function()
        require('fzf-lua').highlights()
      end,
      desc = 'Search highlights groups',
    },
    {
      '<leader>fm',
      function()
        require('fzf-lua').marks()
      end,
      desc = 'Search marks in buffer',
    },
    {
      '<leader>fk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = 'Search defined keymaps',
    },
    {
      '<leader>fl',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = 'Live grep across files',
    },
    {
      '<leader>fg',
      function()
        require('fzf-lua').git_files()
      end,
      desc = 'Search tracked Git files',
    },
    {
      '<leader>fb',
      function()
        require('fzf-lua').git_branches()
      end,
      desc = 'Search Git branches',
    },
    {
      '<leader>fc',
      function()
        require('fzf-lua').git_commits()
      end,
      desc = 'Search Git commits',
    },
    {
      '<leader>fB',
      function()
        require('fzf-lua').git_bcommits()
      end,
      desc = 'Search buffer Git commits',
    },
    {
      '<leader>fr',
      function()
        require('fzf-lua').resume()
      end,
      desc = 'Resume last search session',
    },
    {
      '<leader>fR',
      function()
        require('fzf-lua').lsp_references()
      end,
      desc = 'References (LSP)',
    },
    {
      '<leader>fD',
      function()
        require('fzf-lua').lsp_definitions()
      end,
      desc = 'Definitions (LSP)',
    },
    {
      '<leader>fi',
      function()
        require('fzf-lua').lsp_implementations()
      end,
      desc = 'Implementations (LSP)',
    },
    {
      '<leader>ft',
      function()
        require('fzf-lua').lsp_typedefs()
      end,
      desc = 'Type Definitions (LSP)',
    },
    {
      '<leader>fN',
      function()
        require('fzf-lua').lsp_document_diagnostics()
      end,
      desc = 'Document Diagnostics (LSP)',
    },
  },

  config = function(_, opts)
    local fzf = require 'fzf-lua'
    fzf.setup(opts)

    vim.api.nvim_create_user_command('FzfGitFiles', function()
      fzf.fzf_exec('git ls-files', { prompt = 'Git Files > ' })
    end, {})
  end,
}
