return {
  "szw/vim-maximizer",
  keys = {
    { "<leader>ts", "<cmd>MaximizerToggle<CR>", desc = "Toggle Split Maximization" },
  },
  init = function()
    vim.g.maximizer_set_default_mapping = 0
  end,
}
