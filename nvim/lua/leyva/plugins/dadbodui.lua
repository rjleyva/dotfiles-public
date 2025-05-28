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
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  keys = {
    { "<leader>db", "<cmd>DBUI<cr>", desc = "Open DBUI" },
  },
  opts = {
    db_ui_use_nerd_fonts = 1,
  },
  config = function(_, opts)
    if type(opts) == "table" then
      for k, v in pairs(opts) do
        vim.g[k] = v
      end
    end
  end,
}
