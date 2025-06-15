return {
  'christoomey/vim-tmux-navigator',
  keys = {
    { '<C-h>', desc = 'Navigate to left tmux pane' },
    { '<C-j>', desc = 'Navigate to down tmux pane' },
    { '<C-k>', desc = 'Navigate to up tmux pane' },
    { '<C-l>', desc = 'Navigate to right tmux pane' },
  },
  config = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
}
