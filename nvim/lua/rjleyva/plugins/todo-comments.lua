return {
  "folke/todo-comments.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      TODO = { alt = { "WIP", "FIXME" } },
      HACK = { alt = { "TODO", "TEMP" } },
    },
    highlight = {
      before = "fg",
      keyword = "bg",
      after = "fg",
    },
  },
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Todo: Next comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Todo: Previous comment",
    },
  },
  config = function(_, opts)
    require("todo-comments").setup(opts)
  end,
}
