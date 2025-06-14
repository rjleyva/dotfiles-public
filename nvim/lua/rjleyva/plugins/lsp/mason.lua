return {
  "williamboman/mason.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  opts = {
    ui = {
      border = "none",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
    log_level = vim.log.levels.WARN,
    tools = {
      ensure_installed = {
        "selene",
        "prettier",
        "stylua",
        "eslint_d",
        "js-debug-adapter",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    require("mason-tool-installer").setup(opts.tools)
  end,
}
