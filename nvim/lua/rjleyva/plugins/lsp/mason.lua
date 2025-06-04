return {
  "williamboman/mason.nvim",
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
            check_outdated_packages_on_open = true,
          },
          border = "rounded",
        },
        log_level = vim.log.levels.WARN,
      },
      mason_lspconfig = {
        ensure_installed = {
          "cssls",
          "emmet_ls",
          "graphql",
          "html",
          "jsonls",
          "lua_ls",
          "prismals",
          "ts_ls",
          "vtsls",
        },
        automatic_installation = true,
        automatic_enable = false,
      },
      mason_tool_installer = {
        ensure_installed = {
          "black",
          "eslint_d",
          "isort",
          "prettier",
          "stylua",
          "stylelint",
        },
        automatic_installation = true,
        automatic_enable = true,
        run_on_start = true,
        start_delay = 5000,
      },
    }
  end,
  config = function(_, opts)
    require("mason").setup(opts.mason)
    require("mason-lspconfig").setup(opts.mason_lspconfig)
    require("mason-tool-installer").setup(opts.mason_tool_installer)
  end,
}
