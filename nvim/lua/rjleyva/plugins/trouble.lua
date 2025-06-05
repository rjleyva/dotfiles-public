return {
  "folke/trouble.nvim",
  version = "v3.7.1",
  dependencies = { "folke/todo-comments.nvim" },
  opts = {
    use_diagnostic_signs = true,
    action_keys = {
      close = "q",
      refresh = "r",
      jump = "<cr>",
      cancel = "<esc>",
      history = "u",
      toggle_mode = "m",
    },
  },
  keys = {
    { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Workspace diagnostics" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Document diagnostics" },
    { "<leader>xf", "<cmd>Trouble quickfix toggle<CR>", desc = "Quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "TODOs" },
  },
  config = function(_, opts)
    require("trouble").setup(opts)
  end,
}
