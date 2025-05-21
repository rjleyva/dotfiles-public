return {
  "folke/trouble.nvim",
  version = "*",
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
    { ";xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Trouble: Workspace Diagnostics" },
    { ";xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Trouble: Document Diagnostics" },
    { ";xf", "<cmd>Trouble quickfix toggle<CR>", desc = "Trouble: Quickfix List" },
    { ";xl", "<cmd>Trouble loclist toggle<CR>", desc = "Trouble: Location List" },
    { ";xt", "<cmd>Trouble todo toggle<CR>", desc = "Trouble: TODO Comments" },
  },
  config = function(_, opts)
    require("trouble").setup(opts)
  end,
}
