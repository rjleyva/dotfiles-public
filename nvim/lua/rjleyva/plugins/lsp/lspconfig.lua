return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "folke/neodev.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      library = vim.api.nvim_get_runtime_file("", true),
      diagnostics = { enable = true },
    },
    {
      "saghen/blink.cmp",
      lazy = true,
      config = true,
    },
    {
      "antosha417/nvim-lsp-file-operations",
      event = "BufReadPre",
      config = true,
    },
    {
      "b0o/schemastore.nvim",
      lazy = true,
    },
    {
      "ibhagwan/fzf-lua",
      cmd = { "FzfLua" },
    },
  },

  config = function()
    if vim.bo.filetype == "lua" then
      require("neodev").setup({})
    end

    local lspconfig = require("lspconfig")
    local capabilities = require("blink-cmp").get_lsp_capabilities()

    vim.diagnostic.config({
      float = { border = "rounded" },
    })

    local servers = {
      astro = {},
      svelte = {},
      ts_ls = {},
      jsonls = {
        on_new_config = function(config)
          local ok, schemastore = pcall(require, "schemastore")
          if ok then
            config.settings = config.settings or {}
            config.settings.json = config.settings.json or {}
            config.settings.json.schemas = schemastore.json.schemas()
          end
        end,
        settings = {
          json = {
            validate = { enable = true },
          },
        },
      },
      emmet_ls = {
        filetypes = {
          "html",
          "astro",
          "svelte",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "css",
          "scss",
          "sass",
          "less",
        },
        init_options = {
          html = {
            options = { ["bem.enabled"] = true },
          },
        },
      },
      graphql = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      },
    }

    for name, opts in pairs(servers) do
      lspconfig[name].setup(vim.tbl_deep_extend("force", {
        capabilities = capabilities,
      }, opts))
    end
  end,

  keys = {
    {
      "<leader>lr",
      function()
        require("fzf-lua").lsp_references()
      end,
      desc = "References (LSP)",
    },
    {
      "<leader>ld",
      function()
        require("fzf-lua").lsp_definitions()
      end,
      desc = "Definitions (LSP)",
    },
    {
      "<leader>li",
      function()
        require("fzf-lua").lsp_implementations()
      end,
      desc = "Implementations (LSP)",
    },
    {
      "<leader>lt",
      function()
        require("fzf-lua").lsp_typedefs()
      end,
      desc = "Type Definitions (LSP)",
    },
    {
      "<leader>lx",
      function()
        require("fzf-lua").lsp_document_diagnostics()
      end,
      desc = "Document Diagnostics (LSP)",
    },
    {
      "<leader>lh",
      function()
        vim.lsp.buf.hover({ border = "rounded" })
      end,
      desc = "Hover (LSP)",
    },
    {
      "<leader>lc",
      function()
        vim.lsp.buf.code_action()
      end,
      mode = { "n", "v" },
      desc = "Action (LSP)",
    },
    {
      "<leader>ln",
      function()
        vim.lsp.buf.rename()
      end,
      desc = "Rename (LSP)",
    },
    {
      "<leader>ll",
      function()
        vim.diagnostic.open_float(nil, { focusable = true, border = "rounded" })
      end,
      desc = "Line Diagnostics",
    },
    {
      "[d",
      function()
        vim.diagnostic.goto_prev({ float = true, border = "rounded" })
      end,
      desc = "Prev Diagnostic (LSP)",
    },
    {
      "]d",
      function()
        vim.diagnostic.goto_next({ float = true, border = "rounded" })
      end,
      desc = "Next Diagnostic (LSP)",
    },
    {
      "<leader>rs",
      function()
        for _, client in pairs(vim.lsp.get_clients()) do
          client:stop()
        end
        vim.defer_fn(function()
          vim.cmd("edit")
        end, 100)
      end,
      desc = "Restart All Active LSP Clients (safe)",
    },
  },
}
