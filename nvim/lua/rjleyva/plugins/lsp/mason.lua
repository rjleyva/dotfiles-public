return {
  "williamboman/mason.nvim",
  version = "*",
  after = "neodev.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "folke/neodev.nvim",
  },
  opts = function()
    return {
      mason = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
            check_outdated_packages_on_open = false,
          },
          border = "none",
        },
        log_level = vim.log.levels.WARN,
      },
      mason_lspconfig = {
        ensure_installed = {
          "astro",
          "svelte",
          "ts_ls",
          "html",
          "cssls",
          "tailwindcss",
          "lua_ls",
          "graphql",
          "jsonls",
          "emmet_ls",
          "vtsls",
        },
        automatic_installation = true,
      },
      mason_tool_installer = {
        ensure_installed = {
          "selene",
          "prettier",
          "stylua",
          "eslint_d",
        },
        automatic_installation = true,
      },
    }
  end,
  config = function(_, opts)
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup(opts.mason)
    mason_lspconfig.setup(opts.mason_lspconfig)
    mason_tool_installer.setup(opts.mason_tool_installer)
  end,
}
