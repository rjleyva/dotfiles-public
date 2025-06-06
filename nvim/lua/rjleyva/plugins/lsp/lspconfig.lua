return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    {
      "folke/neodev.nvim",
      opts = {
        library = { enabled = true },
        diagnostics = { enable = true },
      },
    },
    "ibhagwan/fzf-lua",
    { "b0o/schemastore.nvim", lazy = true },
  },

  opts = function()
    local capabilities = require("blink-cmp").get_lsp_capabilities()
    local schemastore = require("schemastore")

    return {
      capabilities = capabilities,
      servers = {
        astro = { filetypes = "astro" },
        svelte = { filetypes = { "svelte", "javascript", "typescript" } },
        ts_ls = {
          filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        },
        jsonls = {
          settings = {
            json = {
              schemas = schemastore.json.schemas(),
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
              options = {
                ["bem.enabled"] = true,
              },
            },
          },
        },
        graphql = {
          filetypes = {
            "graphql",
            "gql",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              telemetry = { enable = false },
            },
          },
        },
      },
    }
  end,

  config = function(_, opts)
    local lspconfig = require("lspconfig")

    vim.diagnostic.config({
      float = {
        border = "rounded",
      },
    })

    for name, server_opts in pairs(opts.servers) do
      lspconfig[name].setup(vim.tbl_deep_extend("force", {
        capabilities = opts.capabilities,
      }, server_opts))
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
      desc = "Action (LSP)",
      mode = { "n", "v" },
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
      desc = "Restart All Active Clients (LSP)",
    },
  },
}
