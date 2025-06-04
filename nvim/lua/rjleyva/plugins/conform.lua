return {
  "stevearc/conform.nvim",
  version = "*",
  enabled = true,
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
    local ok, conform = pcall(require, "conform")
    if not ok then
      vim.notify("conform.nvim failed to load!", vim.log.levels.ERROR)
      return
    end

    conform.setup(opts)

    vim.keymap.set({ "n", "v" }, "<leader>pf", function()
      conform.format({ async = false, lsp_fallback = true })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
