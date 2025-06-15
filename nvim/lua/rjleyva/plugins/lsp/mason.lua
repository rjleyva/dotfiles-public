return {
  "williamboman/mason.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
      opts = {
        ensure_installed = {
          "selene",
          "eslint_d",
          "pylint",
          "golangci-lint",
          "shfmt",
          "stylua",
          "prettier",
          "black",
          "isort",
          "goimports",
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 24,
      },
    },
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "none",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "marksman",
        "html",
        "cssls",
        "tailwindcss",
        "astro",
        "svelte",
        "vtsls",
        "eslint",
        "jsonls",
        "yamlls",
        "emmet_language_server",
        "pyright",
        "gopls",
      },
      automatic_enable = true,
      automatic_installation = false,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        local has_installer, installer = pcall(require, "mason-tool-installer")
        if has_installer then
          installer.run_on_start()
        end
      end,
    })
  end,
}
