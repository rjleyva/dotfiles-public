return {
  "MagicDuck/grug-far.nvim",
  version = "*",
  lazy = true,
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    headerMaxWidth = 80,
  },
  keys = {
    {
      "<leader>gf",
      function()
        local grug = require("grug-far")
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        grug.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
  config = function(_, opts)
    local grug = require("grug-far")
    grug.setup(opts)
  end,
}
