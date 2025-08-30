local M = {}

M.spec = {
  'b0o/schemastore.nvim',
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  ft = { 'json', 'jsonc' },
}

return M.spec
