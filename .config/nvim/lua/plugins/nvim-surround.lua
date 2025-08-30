local M = {}

M.spec = {
  'kylechui/nvim-surround',
  version = 'v3.1.2',

  opts = {
    keymaps = {
      normal = 'sm',
      normal_cur = 'sy',
      normal_line = 'sl',
      normal_cur_line = 'sY',
      visual = 's',
      visual_line = 'sg',
      delete = 'sd',
      change = 'sc',
    },
  },

  keys = {
    { 'sm', desc = 'Surround (Manual)', mode = 'n' },
    { 'sy', desc = 'Surround word', mode = 'n' },
    { 'sl', desc = 'Surround line', mode = 'n' },
    { 'sY', desc = 'Surround full line', mode = 'n' },
    { 'sd', desc = 'Delete surrounding', mode = 'n' },
    { 'sc', desc = 'Change surrounding', mode = 'n' },
    { 's', desc = 'Surround (Visual)', mode = 'v' },
  },
}

return M.spec
