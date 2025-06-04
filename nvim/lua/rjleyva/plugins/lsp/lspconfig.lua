return {
  "neovim/nvim-lspconfig",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    {
      "folke/neodev.nvim",
      opts = {
        diagnostics = { enable = true },
      },
    },
    "ibhagwan/fzf-lua",
    { "b0o/schemastore.nvim", lazy = true },
  },

  opts = function()
    local capabilities = require("blink-cmp").get_lsp_capabilities()

    local servers = {
      astro = {},
      svelte = { filetypes = { "svelte", "javascript", "typescript" } },
      tsserver = { filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } },
      jsonls = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
      emmet_ls = {
        filetypes = {
          "html",
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
    }

    return {
      capabilities = capabilities,
      servers = servers,
    }
  end,

  config = function(_, opts)
    local lspconfig = require("lspconfig")
    local fzf = require("fzf-lua")

    for name, server_opts in pairs(opts.servers) do
      lspconfig[name].setup(vim.tbl_deep_extend("force", {
        capabilities = opts.capabilities,
      }, server_opts))
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local buf = ev.buf
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
        end

        map("n", "gR", fzf.lsp_references, "LSP: References")
        map("n", "gd", fzf.lsp_definitions, "LSP: Definitions")
        map("n", "gD", vim.lsp.buf.declaration, "LSP: Declaration")
        map("n", "gi", fzf.lsp_implementations, "LSP: Implementations")
        map("n", "gt", fzf.lsp_typedefs, "LSP: Type Definitions")
        map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Actions")
        map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
        map("n", "<leader>D", fzf.lsp_document_diagnostics, "LSP: Document Diagnostics")
        map("n", "<leader>d", vim.diagnostic.open_float, "LSP: Line Diagnostics")
        map("n", "[d", function()
          vim.diagnostic.goto_prev({ float = true })
        end, "LSP: Prev Diagnostic")
        map("n", "]d", function()
          vim.diagnostic.goto_next({ float = true })
        end, "LSP: Next Diagnostic")
        map("n", "<leader>rs", "<cmd>LspRestart<CR>", "LSP: Restart")
      end,
    })
  end,
}
