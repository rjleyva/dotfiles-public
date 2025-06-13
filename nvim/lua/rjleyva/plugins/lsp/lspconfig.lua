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
    local util = require("lspconfig.util")
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
      "typescript",
      "javascriptreact",
      "typescriptreact",
    }

    local web_filetypes = {
      "html",
      "css",
      "scss",
      "sass",
      "less",
      "svelte",
      "astro",
      unpack(ts_filetypes),
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
              allowDefinedTypes = true, -- optional
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
            virtual_text = false,
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
      marksman = {
        filetypes = { "markdown" },
        root_dir = function(fname)
          return root_pattern(".git", ".marksman.toml", ".marksman.json")(fname) or vim.fn.getcwd()
        end,
        single_file_support = true,
      },

      html = {
        filetypes = { "html" },
        root_dir = root_pattern("index.html", "package.json", ".git"),
        single_file_support = true,
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
          scss = {
            validate = true,
            lint = {
              unknownAtRules = "warning",
            },
          },
          less = {
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
              recommendedVariantOrder = "error", -- optional
            },
            experimental = {
              classRegex = {
                "tw`([^`]*)",
                'tw="([^"]*)',
                "tw$begin:math:text$([^)]*)\\$end:math:text$",
                -- optional:
                'className="([^"]*)"',
                "className={`([^`]*)`}",
              },
            },
          },
        },
      },

      -- Frontend frameworks
      astro = {
        filetypes = { "astro" },
        root_dir = root_pattern("astro.config.mjs", "astro.config.ts", "package.json", ".git"),
        settings = {
          astro = {
            diagnostics = {
              enabled = true,
            },
            plugin = {
              typescript = {
                diagnostics = { enabled = true },
              },
              eslint = {
                enabled = false, -- handled by conform
              },
            },
          },
        },
        single_file_support = true,
      },

      svelte = {
        filetypes = { "svelte" },
        root_dir = root_pattern("svelte.config.js", "svelte.config.ts", "package.json", ".git"),
        settings = {
          svelte = {
            plugin = {
              typescript = {
                diagnostics = { enabled = true },
              },
              eslint = {
                enabled = false, -- handled by conform
              },
            },
          },
        },
        single_file_support = true,
      },

      -- JavaScript/TypeScript
      vtsls = {
        filetypes = ts_filetypes,
        root_dir = root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
        settings = {
          typescript = {
            inlayHints = ts_inlay_hints,
            updateImportsOnFileMove = { enabled = "always" },
            completions = {
              completeFunctionCalls = true,
            },
          },
          javascript = {
            inlayHints = ts_inlay_hints,
            completions = {
              completeFunctionCalls = true,
            },
          },
          vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
        },
        on_new_config = function(new_config, new_root_dir)
          local tsdk = util.path.join(new_root_dir, "node_modules", "typescript", "lib")
          if vim.fn.isdirectory(tsdk) == 1 then
            new_config.init_options = new_config.init_options or {}
            new_config.init_options.typescript = {
              tsdk = tsdk,
            }
          end
        end,
      },

      -- Tooling / Infra
      jsonls = {
        filetypes = { "json", "jsonc" },
        root_dir = root_pattern(".git", "package.json"),
        settings = {
          json = {
            validate = { enable = true },
          },
        },
        on_new_config = function(config)
          local ok, schemastore = pcall(require, "schemastore")
          if ok then
            config.settings = config.settings or {}
            config.settings.json = config.settings.json or {}

            config.settings.json.schemas = schemastore.json.schemas()
          end
        end,
      },

      yamlls = {
        filetypes = { "yaml", "yml" },
        root_dir = root_pattern(".git", ".github", ".yaml"),
        settings = {
          yaml = {
            validate = true,
            format = {
              enable = false, -- formatting is handled by conform
            },
            keyOrdering = false, -- allow flexible ordering (useful for GitHub Actions, k8s)
            schemaStore = {
              enable = false, -- we override this manually
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      },

      emmet_ls = {
        filetypes = {
          "html",
          "css",
          "scss",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "astro",
        },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
              ["output.selfClosingTag"] = true,
            },
          },
          javascriptreact = {
            options = {
              ["bem.enabled"] = false,
              ["output.selfClosingTag"] = false,
            },
          },
          typescriptreact = {
            options = {
              ["bem.enabled"] = false,
              ["output.selfClosingTag"] = false,
            },
          },
          svelte = {
            options = {
              ["bem.enabled"] = true,
              ["output.selfClosingTag"] = true,
            },
          },
          astro = {
            options = {
              ["bem.enabled"] = true,
              ["output.selfClosingTag"] = true,
            },
          },
        },
      },

      -- Backend / API / Data Layer
      graphql = {
        filetypes = vim.tbl_extend("force", ts_filetypes, { "graphql" }),
        root_dir = root_pattern(
          ".graphqlrc",
          ".graphqlrc.json",
          ".graphqlrc.yaml",
          ".graphqlrc.yml",
          ".graphqlrc.js",
          ".graphqlrc.ts",
          "graphql.config.json",
          "graphql.config.js",
          "graphql.config.ts",
          "package.json",
          ".git"
        ),
        single_file_support = true,
        settings = {
          graphql = {},
        },
      },

      pyright = {
        root_dir = root_pattern("pyproject.toml", "setup.py", "requirements.txt", ".git"),
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "strict", -- or "basic"
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace", -- analyze all files, not just open ones
              autoImportCompletions = true,
              stubPath = "typings", -- useful for custom stubs if needed
            },
          },
        },
      },

      gopls = {
        root_dir = root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            semanticTokens = true,
            matcher = "Fuzzy",
            directoryFilters = { "-.git", "-node_modules", "-vendor" },
            analyses = {
              unusedparams = true,
              unreachable = true,
              fieldalignment = true,
              nilness = true,
              unusedwrite = true,
              shadow = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
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
