return {
  "williamboman/mason.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "jay-babu/mason-null-ls.nvim",
    "nvimtools/none-ls.nvim",
  },
  opts = function()
    return {
      mason = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
            check_outdated_packages_on_open = true,
          },
          border = "rounded",
        },
        -- luacheck: globals vim
        log_level = vim.log.levels.WARN,
      },
      mason_lspconfig = {
        ensure_installed = {
          "astro",
          "cssls",
          "emmet_ls",
          "graphql",
          "html",
          "jsonls",
          "lua_ls",
          "prismals",
          "svelte",
          "ts_ls",
          "vtsls",
        },
        automatic_installation = true,
        automatic_enable = false,
      },
      mason_tool_installer = {
        ensure_installed = {
          "eslint_d",
          "prettier",
          "stylua",
        },
        automatic_installation = true,
        automatic_enable = true,
        run_on_start = true,
        start_delay = 1000,
      },
      mason_null_ls = {
        ensure_installed = { "eslint_d", "prettier", "stylua" },
        automatic_installation = true,
        handlers = {},
      },
    }
  end,
  config = function(_, opts)
    require("mason").setup(opts.mason)
    require("mason-lspconfig").setup(opts.mason_lspconfig)
    require("mason-tool-installer").setup(opts.mason_tool_installer)
    require("mason-null-ls").setup(opts.mason_null_ls)

    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint_d,
      },
    })
  end,
}
