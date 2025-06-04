return {
  "kdheepak/lazygit.nvim",
  version = "*",
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
