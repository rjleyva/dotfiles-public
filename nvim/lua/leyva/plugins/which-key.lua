return {
  "folke/which-key.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    plugins = {
      spelling = { enabled = false },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
      },
    },
    win = {
      border = "rounded",
    },
    layout = {
      align = "center",
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps",
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
}
