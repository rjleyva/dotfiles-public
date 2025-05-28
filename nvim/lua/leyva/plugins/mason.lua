return {
  "williamboman/mason.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
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
          "html",
          "cssls",
          "lua_ls",
          "ts_ls",
          "astro",
          "svelte",
          "emmet_ls",
          "pyright",
          "graphql",
          "prismals",
        },
        automatic_enable = false,
      },
      mason_tool_installer = {
        ensure_installed = {
          "prettier",
          "stylua",
          "isort",
          "black",
          "eslint_d",
          "pylint",
        },
        automatic_enable = true,
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
