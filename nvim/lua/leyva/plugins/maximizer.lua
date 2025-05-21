return {
  "szw/vim-maximizer",
  event = "VeryLazy",
  cmd = { "MaximizerToggle" },
  keys = {
    { "<leader>ms", "<cmd>MaximizerToggle<CR>", desc = "Maximize/Minimize a Split" },
  },
}
