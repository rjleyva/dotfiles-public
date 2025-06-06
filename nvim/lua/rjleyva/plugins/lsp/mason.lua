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
          "biome",
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
        ensure_installed = { "biome", "eslint_d", "prettier", "stylua" },
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

    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    if not string.find(vim.env.PATH, mason_bin, 1, true) then
      vim.env.PATH = vim.env.PATH .. ":" .. mason_bin
    end

    local null_ls = require("null-ls")
    local util = require("lspconfig.util")
    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
    }

    local root = util.root_pattern(
      "biome.json",
      ".eslintrc.js",
      ".eslintrc.json",
      "eslint.config.js",
      "package.json",
      ".git"
    )(vim.fn.expand("%:p")) or vim.fn.getcwd()

    if vim.fn.filereadable(root .. "/biome.json") == 1 then
      table.insert(sources, null_ls.builtins.formatting.biome)
      table.insert(sources, null_ls.builtins.diagnostics.biome)
    elseif
      vim.fn.filereadable(root .. "/.eslintrc.js") == 1
      or vim.fn.filereadable(root .. "/.eslintrc.json") == 1
      or vim.fn.filereadable(root .. "/eslint.config.js") == 1
    then
      table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
    end

    null_ls.setup({ sources = sources })
  end,
}
