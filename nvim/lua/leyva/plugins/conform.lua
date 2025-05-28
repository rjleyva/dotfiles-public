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
      async = false,
      timeout_ms = 500,
    },
  },
  config = function(_, opts)
    local function modify_opts(original_opts)
      if not original_opts.formatters_by_ft.lua then
        original_opts.formatters_by_ft.lua = { "stylua" }
      end

      if vim.fn.has("unix") == 1 then
        original_opts.format_on_save.async = false
      end

      return original_opts
    end

    opts = modify_opts(opts)

    local ok, conform = pcall(require, "conform")
    if not ok then
      vim.notify("conform.nvim failed to load!", vim.log.levels.ERROR)
      return
    end

    conform.setup(opts)

    vim.keymap.set({ "n", "v" }, "<leader>pf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        quiet = false,
        timeout_ms = 3000,
      })
    end, { desc = "Format file or range (in visual mode)" })

    if opts.format_on_save then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
        callback = function()
          conform.format()
        end,
      })
    end
  end,
}
