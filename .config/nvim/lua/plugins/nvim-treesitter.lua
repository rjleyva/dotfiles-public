local M = {}

M.spec = {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'TSUpdate', 'TSUpdateSync', 'TSInstall' },
  build = ':TSUpdate',

  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-context',
      event = 'BufReadPost',
      config = function()
        require('treesitter-context').setup {
          enabled = true,
          max_lines = 3,
          trim_scope = 'outer',
          mode = 'cursor',
        }
      end,
    },
    {
      'windwp/nvim-ts-autotag',
      event = 'InsertEnter',
      config = function()
        require('nvim-ts-autotag').setup()
      end,
    },
    {
      'andymass/vim-matchup',
      event = { 'BufReadPost', 'BufNewFile' },
      init = function()
        vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_timeout = 200
        vim.g.matchup_matchparen_insert_timeout = 100
        vim.g.matchup_matchparen_hi_surround_always = 1
      end,
    },
  },

  opts = function()
    return {
      ensure_installed = {
        'astro',
        'bash',
        'css',
        'diff',
        'gitignore',
        'graphql',
        'html',
        'http',
        'javascript',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'svelte',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
        'query',
        'regex',
      },
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },

      matchup = {
        enable = true,
        disable_virtual_text = false,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          node_decremental = '<BS>',
          scope_incremental = false,
        },
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']a'] = '@parameter.inner',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']A'] = '@parameter.inner',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[a'] = '@parameter.inner',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[A'] = '@parameter.inner',
          },
        },
      },
    }
  end,

  keys = {
    {
      '<leader>ci',
      function()
        if vim.fn.mode() == 'n' then
          vim.cmd 'normal! v'
        end
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes('<C-space>', true, false, true),
          ''
        )
      end,
      desc = 'Increment Selection',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cd',
      function()
        vim.fn.feedkeys(
          vim.api.nvim_replace_termcodes('<BS>', true, false, true),
          ''
        )
      end,
      desc = 'Decrement Selection',
      mode = { 'v' },
    },
    { ']f', desc = 'Next Function Start' },
    { ']F', desc = 'Next Function End' },
    { ']a', desc = 'Next Parameter Start' },
    { ']A', desc = 'Next Parameter End' },
    { '[f', desc = 'Prev Function Start' },
    { '[F', desc = 'Prev Function End' },
    { '[a', desc = 'Prev Parameter Start' },
    { '[A', desc = 'Prev Parameter End' },
  },

  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    -- MDX support
    vim.filetype.add {
      extension = {
        mdx = 'mdx',
      },
    }

    vim.treesitter.language.register('markdown', 'mdx')
  end,
}

return M.spec
