return {
  "stevearc/conform.nvim",
  version = "v9.0.0",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      html = { "prettier" },
      css = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      graphql = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
    },
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },
  },

  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({ async = false, lsp_fallback = true })
    end, { desc = "Manually format file or range" })
  end,
}
