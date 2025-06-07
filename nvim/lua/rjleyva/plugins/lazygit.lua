return {
  "kdheepak/lazygit.nvim",
  cmd = { "LazyGit" },
  keys = {
    {
      "<leader>gg",
      "<cmd>LazyGit<cr>",
      desc = "Open LazyGit",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
