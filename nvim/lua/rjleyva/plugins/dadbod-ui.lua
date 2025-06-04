return {
  "kristijanhusak/vim-dadbod-ui",
  version = "*",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "mysql", "plsql", "graphql" },
      lazy = true,
    },
  },
  keys = {
    { "<leader>db", "<cmd>DBUI<cr>", desc = "Open DBUI" },
  },
  opts = {
    db_ui_use_nerd_fonts = 1,
  },
  config = function(_, opts)
    for k, v in pairs(opts) do
      vim.g[k] = v
    end
  end,
}
