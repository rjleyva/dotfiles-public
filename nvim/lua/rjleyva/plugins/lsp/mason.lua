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
    -- Setup Mason ecosystem plugins
    require("mason").setup(opts.mason)
    require("mason-lspconfig").setup(opts.mason_lspconfig)
    require("mason-tool-installer").setup(opts.mason_tool_installer)
    require("mason-null-ls").setup(opts.mason_null_ls)

    -- Add Mason bin to PATH early
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    if not string.find(vim.env.PATH, mason_bin, 1, true) then
      vim.env.PATH = vim.env.PATH .. ":" .. mason_bin
    end

    local null_ls = require("null-ls")
    local util = require("lspconfig.util")

    -- Custom eslint_d generator
    local eslint_d = {
      method = null_ls.methods.DIAGNOSTICS,
      filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
      generator = null_ls.generator({
        command = "eslint_d",
        args = { "--format", "json", "--stdin", "--stdin-filename", "$FILENAME" },
        to_stdin = true,
        from_stderr = false,
        format = "json",
        check_exit_code = function(code)
          return code <= 1 -- 0 = no errors, 1 = lint errors found
        end,
        on_output = function(params)
          -- Uncomment for debug:
          -- print(vim.inspect(params.output))

          local diagnostics = {}
          -- Defensive fallback for output shape
          local output = params.output and params.output[1] or {}

          if output.messages then
            for _, message in ipairs(output.messages) do
              table.insert(diagnostics, {
                row = message.line,
                col = message.column,
                end_row = message.endLine or message.line,
                end_col = message.endColumn or message.column,
                message = message.message,
                source = "eslint_d",
                severity = ({
                  [2] = vim.diagnostic.severity.ERROR,
                  [1] = vim.diagnostic.severity.WARN,
                })[message.severity] or vim.diagnostic.severity.INFO,
              })
            end
          end
          return diagnostics
        end,
      }),
    }

    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
    }

    local root = util.root_pattern(".eslintrc.js", ".eslintrc.json", "eslint.config.js", "package.json", ".git")(
      vim.fn.expand("%:p")
    ) or vim.fn.getcwd()

    if
      vim.fn.filereadable(root .. "/.eslintrc.js") == 1
      or vim.fn.filereadable(root .. "/.eslintrc.json") == 1
      or vim.fn.filereadable(root .. "/eslint.config.js") == 1
    then
      table.insert(sources, eslint_d)
    end

    vim.defer_fn(function()
      null_ls.setup({ sources = sources })
    end, 100)
  end,
}
