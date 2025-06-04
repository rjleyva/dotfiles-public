return {
  "kristijanhusak/vim-dadbod-ui",
  version = "*",
  ft = { "sql", "mysql", "plsql", "graphql" },
  dependencies = {
    "tpope/vim-dadbod",
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "mysql", "plsql", "graphql" },
    },
  },
  keys = {
    { "<leader>db", "<cmd>DBUI<cr>", desc = "Open DBUI" },
    { "<leader>dt", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI" },
    { "<leader>da", "<cmd>DBUIAddConnection<cr>", desc = "Add DB connection" },
    { "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "Find DB buffer" },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
