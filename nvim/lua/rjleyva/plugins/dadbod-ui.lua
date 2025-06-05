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
    { "<leader>dl", "<cmd>DBUI<cr>", desc = "Launch Database UI Explorer" },
    { "<leader>dt", "<cmd>DBUIToggle<cr>", desc = "Toggle visibility of Database UI" },
    { "<leader>da", "<cmd>DBUIAddConnection<cr>", desc = "Add a new database connection" },
    { "<leader>ds", "<cmd>DBUIFindBuffer<cr>", desc = "Search and open an existing DBUI buffer" },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
