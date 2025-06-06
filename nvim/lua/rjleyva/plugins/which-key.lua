return {
  "folke/which-key.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
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
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      { "<leader>w", group = "Window Managment" },
      { "<leader>t", group = "Tab Management" },
      { "<leader>e", group = "Neo Tree Explorer" },
      { "<leader>f", group = "Fuzzy Finder" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Dadbod" },
      { "<leader>l", group = "LSP Actions" },
      { "<leader>x", group = "Diagnostics" },
      { "<leader>g", group = "Git" },
      { "<leader>r", group = "Refactoring" },
    })
  end,
}
