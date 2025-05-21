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
  config = function(_, opts)
    local todo_comments = require("todo-comments")
    local keymap = vim.keymap

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Todo: Next comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Todo: Previous comment" })

    todo_comments.setup(opts)
  end,
}
