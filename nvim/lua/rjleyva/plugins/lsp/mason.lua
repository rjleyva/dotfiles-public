return {
  {
    'williamboman/mason.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      ui = {
        border = 'none',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = {
        'lua_ls',
        'marksman',
        'html',
        'cssls',
        'tailwindcss',
        'astro',
        'svelte',
        'vtsls',
        'eslint',
        'jsonls',
        'yamlls',
        'emmet_language_server',
        'graphql',
        'pyright',
        'gopls',
      },
      automatic_enable = false,
      automatic_installation = false,
    },
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    cmd = { 'MasonToolsInstall', 'MasonToolsUpdate' },
    opts = {
      ensure_installed = {
        'selene',
        'eslint_d',
        'pylint',
        'golangci-lint',
        'shfmt',
        'stylua',
        'prettier',
        'black',
        'isort',
        'goimports',
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 24,
    },
    config = function(_, opts)
      require('mason-tool-installer').setup(opts)

      -- NOTE: Optional: Delay running on start until VeryLazy to reduce startup cost
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          local ok, installer = pcall(require, 'mason-tool-installer')
          if ok then
            installer.run_on_start()
          end
        end,
      })
    end,
  },
}
