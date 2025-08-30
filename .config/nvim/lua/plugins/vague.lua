local M = {}

M.spec = {
  'vague2k/vague.nvim',
  lazy = true,
  event = 'UIEnter',
  opts = {
    -- transparent = true,
  },
  config = function(_, opts)
    require('vague').setup(opts)
    vim.cmd.colorscheme 'vague'
    vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })
  end,
}

return M.spec
