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
    lspconfig = {
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
    tools = {
      ensure_installed = {
        "selene",
        "prettier",
        "stylua",
        "eslint_d",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
  config = function(_, opts)
    require("mason").setup(opts)
    require("mason-lspconfig").setup(opts.lspconfig)
    require("mason-tool-installer").setup(opts.tools)
  end,
}
