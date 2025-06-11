return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "mason-org/mason.nvim",
      version = "^1.0.0",
    },
    {
      "mason-org/mason-lspconfig.nvim",
      version = "^1.0.0",
    },
    "saghen/blink.cmp",
    "ibhagwan/fzf-lua",
    {
      "rjleyva/nvim-lsp-file-operations",
      event = "BufReadPre",
      config = true,
    },
    {
      "b0o/schemastore.nvim",
      lazy = true,
    },
  },

  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = require("blink-cmp").get_lsp_capabilities()
    local root_pattern = require("lspconfig.util").root_pattern

    vim.diagnostic.config({ float = { border = "rounded" } })

    local on_attach = function(_, _) end

    local servers = {
      astro = {
        filetypes = { "astro" },
        root_dir = root_pattern("package.json", "astro.config.mjs", ".git"),
        settings = {
          astro = {
            format = {
              enable = true,
            },
            diagnostics = {
              enabled = true,
            },
            plugin = {
              typescript = {
                diagnostics = {
                  enabled = true,
                },
              },
              eslint = {
                enabled = true,
              },
            },
          },
        },
      },
      svelte = {
        filetypes = { "svelte" },
        root_dir = root_pattern("package.json", "svelte.config.js", "svelte.config.cjs", "svelte.config.ts", ".git"),
        settings = {
          svelte = {
            plugin = {
              typescript = {
                diagnostics = {
                  enabled = true,
                },
              },
            },
          },
        },
      },
      vtsls = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
        root_dir = root_pattern("package.json", "tsconfig.json", ".git"),
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          completions = { completeFunctionCalls = true },
        },
      },
      tailwindcss = {
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "svelte",
          "astro",
        },
        root_dir = root_pattern(
          "tailwind.config.js",
          "tailwind.config.ts",
          "postcss.config.js",
          "package.json",
          ".git"
        ),
        settings = {
          tailwindCSS = {
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidScreen = "error",
            },
            experimental = {
              classRegex = {
                "tw`([^`]*)",
                'tw="([^"]*)',
              },
            },
          },
        },
      },
      jsonls = {
        on_new_config = function(config)
          local ok, schemastore = pcall(require, "schemastore")
          if ok then
            config.settings = config.settings or {}
            config.settings.json = config.settings.json or {}
            config.settings.json.schemas = schemastore.json.schemas()
          end
        end,
        settings = { json = { validate = { enabled = true } } },
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
            options = { ["bem.enabled"] = true },
          },
        },
      },
      graphql = {
        filetypes = {
          "graphql",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              globals = { "vim" },
              disable = {},
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
                "${3rd}/busted/library",
              },
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      },
    }

    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = false,
    })

    for server_name, config in pairs(servers) do
      lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
        capabilities = capabilities,
        on_attach = on_attach,
      }, config))
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
      desc = "Previous Diagnostic",
    },
    {
      "]d",
      function()
        vim.diagnostic.goto_next({ float = true, border = "rounded" })
      end,
      desc = "Next Diagnostic",
    },
    {
      "<leader>ls",
      function()
        for _, client in pairs(vim.lsp.get_clients()) do
          client:stop()
        end
        vim.defer_fn(function()
          vim.cmd("edit")
        end, 100)
      end,
      desc = "Restart All Active LSP Clients (Safe)",
    },
  },
}
