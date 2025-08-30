local M = {}

M.spec = {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  version = '*',

  opts = {
    linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      -- add more if you want:
      -- vue = { 'eslint_d' },
      -- svelte = { 'eslint_d' },
      -- astro = { 'eslint_d' },
    },
  },

  config = function(_, opts)
    local lint = require 'lint'
    lint.linters_by_ft = opts.linters_by_ft

    -- Auto lint on save / insert leave / buffer enter
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup(
        'nvim-lint-autogroup',
        { clear = true }
      ),
      callback = function()
        lint.try_lint()
      end,
    })

    -- Manual lint keymap
    vim.keymap.set('n', '<leader>cl', function()
      lint.try_lint()
    end, { desc = 'Run linter manually (eslint_d)' })

    vim.keymap.set('n', '<leader>ce', function()
      vim.diagnostic.setqflist()
    end, { desc = 'Linter Errors to Quickfix' })
  end,
}

return M.spec
