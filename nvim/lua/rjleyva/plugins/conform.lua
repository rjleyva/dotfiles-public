return {
  "stevearc/conform.nvim",
  version = "v9.0.0",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      markdown = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      lua = { "stylua" },
      astro = { "prettier" },
      svelte = { "prettier" },
      javascript = { "eslint_d", "prettier" },
      typescript = { "eslint_d", "prettier" },
      javascriptreact = { "eslint_d", "prettier" },
      typescriptreact = { "eslint_d", "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      graphql = { "prettier" },
      python = { "isort", "black" },
      gopls = { "goimports" },
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
