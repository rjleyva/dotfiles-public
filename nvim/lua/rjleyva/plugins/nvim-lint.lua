return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  version = '*',
  opts = {
    linters_by_ft = {
      lua = { 'selene' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
    },
  },
  config = function(_, opts)
    local lint = require 'lint'
    lint.linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave', 'BufEnter' }, {
      group = vim.api.nvim_create_augroup(
        'nvim-lint-autogroup',
        { clear = true }
      ),
      callback = function()
        local ft = vim.bo.filetype
        if lint.linters_by_ft[ft] then
          lint.try_lint()
        end
      end,
    })

    vim.keymap.set('n', '<leader>lL', function()
      local ft = vim.bo.filetype
      if lint.linters_by_ft[ft] then
        lint.try_lint()
      else
        vim.notify(
          'No linter configured for filetype: ' .. ft,
          vim.log.levels.WARN
        )
      end
    end, { desc = 'Run linter manually' })

    vim.keymap.set('n', '<leader>le', function()
      vim.diagnostic.setqflist()
    end, { desc = 'Send diagnostics to quickfix list' })
  end,
}
