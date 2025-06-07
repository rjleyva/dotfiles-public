return {
  "ThePrimeagen/refactoring.nvim",
  version = "*",
  keys = {
    {
      "<leader>r",
      function()
        require("refactoring").select_refactor({
          show_success_message = true,
        })
      end,
      mode = "v",
      desc = "Refactor",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
  config = function(_, opts)
    require("refactoring").setup(opts)
  end,
}
