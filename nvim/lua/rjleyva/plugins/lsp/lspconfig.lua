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
    { "saghen/blink.cmp" },
    { "ibhagwan/fzf-lua" },
    {
      "rjleyva/nvim-lsp-file-operations",
      event = "BufReadPre",
      config = true,
    },
    {
      "b0o/schemastore.nvim",
      lazy = true,
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          path = "${3rd}/luv/library",
          words = { "vim%.uv" },
        },
        enabled = function(root_dir)
          return not vim.loop.fs_stat(root_dir .. "/.luarc.json")
        end,
      },
    },
  },

  config = function()
    require("lazydev").setup()

    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = require("blink-cmp").get_lsp_capabilities()
    local root_pattern = require("lspconfig.util").root_pattern

    vim.diagnostic.config({ float = { border = "rounded" } })

    local on_attach = function(_, _) end

    local ts_inlay_hints = {
      includeInlayParameterNameHints = "all",
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    }

    local ts_filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    }

    local web_filetypes = {
      "html",
      "css",
      "scss",
      "sass",
      "less",
      unpack(ts_filetypes),
      "svelte",
      "astro",
    }

    local servers = {
      -- Neovim / Lua
      lua_ls = {
        root_dir = root_pattern(".git", "init.lua"),
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              globals = { "vim" },
              groupFileStatus = {
                library = "Any",
                typedef = "Any",
              },
              neededFileStatus = {
                ["missing-fields"] = "Warning",
              },
            },
            type = {
              enable = true,
              checkTableShape = true,
              strictUnionCheck = true,
              strongNilCheck = true,
            },
            hint = { enable = true },
            completion = { callSnippet = "Replace" },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
          },
        },

        on_attach = function(_, _)
          vim.diagnostic.config({
            virtual_text = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            signs = {
              text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.HINT] = "",
              },
              numhl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticError",
                [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
                [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
                [vim.diagnostic.severity.HINT] = "DiagnosticHint",
              },
            },
          })
        end,
      },

      -- Frontend markup and styles
      html = {
        filetypes = { "html" },
        root_dir = root_pattern("index.html", "package.json", ".git"),
        settings = {
          html = {
            hover = {
              documentation = true,
              references = true,
            },
          },
        },
      },

      cssls = {
        filetypes = { "css", "scss", "less" },
        root_dir = root_pattern("package.json", ".git"),
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "warning",
            },
          },
        },
      },

      tailwindcss = {
        filetypes = web_filetypes,
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
                "tw\\(([^)]*)\\)",
              },
            },
          },
        },
      },

      -- Frontend frameworks
      astro = {
        filetypes = { "astro" },
        root_dir = root_pattern("package.json", "astro.config.mjs", ".git"),
        settings = {
          astro = {
            diagnostics = { enabled = true },
            plugin = {
              typescript = { diagnostics = { enabled = true } },
              eslint = { enabled = false }, -- handled by conform
            },
          },
        },
      },

      svelte = {
        filetypes = { "svelte" },
        root_dir = root_pattern("package.json", "svelte.config.js", "svelte.config.ts", ".git"),
        settings = {
          svelte = {
            plugin = {
              typescript = { diagnostics = { enabled = true } },
              eslint = { enabled = false }, -- handled by conform
            },
          },
        },
      },

      -- JavaScript/TypeScript
      vtsls = {
        filetypes = ts_filetypes,
        root_dir = root_pattern("package.json", "tsconfig.json", ".git"),
        settings = {
          typescript = { inlayHints = ts_inlay_hints },
          javascript = { inlayHints = ts_inlay_hints },
          completions = { completeFunctionCalls = true },
        },
      },

      -- Tooling / Infra
      jsonls = {
        on_new_config = function(config)
          local ok, schemastore = pcall(require, "schemastore")
          if ok then
            config.settings = config.settings or {}
            config.settings.json = config.settings.json or {}
            config.settings.json.schemas = schemastore.json.schemas()
            config.settings.json.validate = { enabled = true }
          end
        end,
      },

      emmet_ls = {
        filetypes = web_filetypes,
        init_options = {
          html = {
            options = { ["bem.enabled"] = true },
          },
        },
      },

      -- Backend / API / Data Layer
      graphql = {
        filetypes = vim.tbl_extend("force", ts_filetypes, { "graphql" }),
      },
    }

    mason.setup()

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = false,
      handlers = {
        function(server_name)
          local config = servers[server_name] or {}
          lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
            capabilities = capabilities,
            on_attach = on_attach,
          }, config))
        end,
      },
    })
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
