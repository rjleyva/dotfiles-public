return {
  "szw/vim-maximizer",
  init = function()
    vim.g.maximizer_set_default_mapping = 0
  end,
  keys = {
    { "<leader>/s", "<cmd>MaximizerToggle<CR>", desc = "Toggle Split Maximization" },
  },
}
