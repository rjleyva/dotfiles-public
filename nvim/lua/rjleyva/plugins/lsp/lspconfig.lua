return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    {
      'williamboman/mason.nvim',
      -- version = "^1.0.0",
    },
    { 'saghen/blink.cmp' },
    { 'ibhagwan/fzf-lua' },
    {
      'rjleyva/nvim-lsp-file-operations',
      event = 'BufReadPre',
      config = true,
    },
    {
      'b0o/schemastore.nvim',
      lazy = true,
    },
    {
      'nvimtools/none-ls.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin:' .. vim.env.PATH

        local null_ls = require 'null-ls'

        null_ls.setup {
          sources = {
            null_ls.builtins.diagnostics.selene.with {
              filetypes = { 'lua' },
              extra_args = function()
                local config_path = vim.fn.stdpath 'config' .. '/selene.toml'
                if vim.fn.filereadable(config_path) == 1 then
                  return { '--config', config_path }
                end
                return {}
              end,
              condition = function(utils)
                local has_config = utils.root_has_file { 'selene.toml' }

                local bufname = vim.api.nvim_buf_get_name(0)
                local cwd = vim.fn.getcwd()

                local function normalize(path)
                  return vim.loop.fs_realpath(path) or path
                end

                local normalized_buf = normalize(bufname)
                local normalized_cwd = normalize(cwd)

                local is_inside_root = normalized_buf
                  and normalized_cwd
                  and normalized_buf:sub(1, #normalized_cwd) == normalized_cwd

                return has_config and is_inside_root
              end,
            },
          },
        }
      end,
    },
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          path = '${3rd}/luv/library',
          words = { 'vim%.uv' },
        },
        enabled = function(root_dir)
          return not vim.loop.fs_stat(root_dir .. '/.luarc.json')
        end,
      },
    },
  },

  config = function()
    require('lazydev').setup()
    require('mason').setup()
    require('mason-lspconfig').setup()

    local capabilities = require('blink-cmp').get_lsp_capabilities()
    local lspconfig = require 'lspconfig'
    local root_pattern = require('lspconfig.util').root_pattern

    vim.diagnostic.config {
      float = { border = 'rounded' },
      virtual_text = false,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.INFO] = '',
          [vim.diagnostic.severity.HINT] = '',
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
          [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
          [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
          [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
        },
      },
    }

    local ts_inlay_hints = {
      includeInlayParameterNameHints = 'all',
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    }

    local ts_filetypes = {
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
    }

    local web_filetypes = {
      'html',
      'css',
      'scss',
      'sass',
      'less',
      'svelte',
      'astro',
      unpack(ts_filetypes),
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(event)
        local bufnr = event.buf
        -- NOTE: Notify when an LSP client attaches to the buffer (for debugging purposes)
        -- Uncomment the next 2 lines to display a notification with the attached LSP client name
        -- local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- vim.notify("LSP attached: " .. (client and client.name or "Unknown"), vim.log.levels.INFO)

        local keys = vim.keymap.set
        local opts = { buffer = bufnr, silent = true }

        keys(
          'n',
          '<leader>lr',
          require('fzf-lua').lsp_references,
          vim.tbl_extend('force', opts, { desc = 'References (LSP)' })
        )
        keys(
          'n',
          '<leader>ld',
          require('fzf-lua').lsp_definitions,
          vim.tbl_extend('force', opts, { desc = 'Definitions (LSP)' })
        )
        keys(
          'n',
          '<leader>li',
          require('fzf-lua').lsp_implementations,
          vim.tbl_extend('force', opts, { desc = 'Implementations (LSP)' })
        )
        keys(
          'n',
          '<leader>lt',
          require('fzf-lua').lsp_typedefs,
          vim.tbl_extend('force', opts, { desc = 'Type Definitions (LSP)' })
        )
        keys(
          'n',
          '<leader>lx',
          require('fzf-lua').lsp_document_diagnostics,
          vim.tbl_extend('force', opts, { desc = 'Document Diagnostics (LSP)' })
        )
        keys('n', '<leader>lh', function()
          vim.lsp.buf.hover { border = 'rounded' }
        end, vim.tbl_extend('force', opts, { desc = 'Hover (LSP)' }))
        keys(
          { 'n', 'v' },
          '<leader>lc',
          vim.lsp.buf.code_action,
          vim.tbl_extend('force', opts, { desc = 'Action (LSP)' })
        )
        keys(
          'n',
          '<leader>ln',
          vim.lsp.buf.rename,
          vim.tbl_extend('force', opts, { desc = 'Rename (LSP)' })
        )
        keys('n', '<leader>ll', function()
          vim.diagnostic.open_float(
            nil,
            { focusable = true, border = 'rounded' }
          )
        end, vim.tbl_extend(
          'force',
          opts,
          { desc = 'Line Diagnostics' }
        ))
        keys('n', '[d', function()
          vim.diagnostic.jump { count = -1, float = true }
        end, vim.tbl_extend(
          'force',
          opts,
          { desc = 'Previous Diagnostic' }
        ))
        keys('n', ']d', function()
          vim.diagnostic.jump { count = 1, float = true }
        end, vim.tbl_extend('force', opts, { desc = 'Next Diagnostic' }))
        keys(
          'n',
          '<leader>ls',
          function()
            for _, c in pairs(vim.lsp.get_clients()) do
              c:stop()
            end
            vim.defer_fn(function()
              vim.cmd 'edit'
            end, 100)
          end,
          vim.tbl_extend(
            'force',
            opts,
            { desc = 'Restart All Active LSP Clients (Safe)' }
          )
        )
      end,
    })

    -- LSP server configurations
    lspconfig.marksman.setup {
      capabilities = capabilities,
      filetypes = { 'markdown' },
      root_dir = function(fname)
        return root_pattern('.git', '.marksman.toml', '.marksman.json')(fname)
          or vim.fn.getcwd()
      end,
      single_file_support = true,
    }

    lspconfig.html.setup {
      capabilities = capabilities,
      filetypes = { 'html' },
      root_dir = root_pattern('index.html', 'package.json', '.git'),
      single_file_support = true,
    }

    lspconfig.cssls.setup {
      capabilities = capabilities,
      filetypes = { 'css', 'scss', 'less' },
      root_dir = root_pattern('package.json', '.git'),
      settings = {
        css = {
          validate = true,
          lint = {
            unknownAtRules = 'warning',
          },
        },
        scss = {
          validate = true,
          lint = {
            unknownAtRules = 'warning',
          },
        },
        less = {
          validate = true,
          lint = {
            unknownAtRules = 'warning',
          },
        },
      },
    }

    lspconfig.tailwindcss.setup {
      capabilities = capabilities,
      filetypes = web_filetypes,
      root_dir = root_pattern(
        'tailwind.config.js',
        'tailwind.config.ts',
        'postcss.config.js',
        'package.json',
        '.git'
      ),
      settings = {
        tailwindCSS = {
          lint = {
            cssConflict = 'warning',
            invalidApply = 'error',
            invalidScreen = 'error',
            recommendedVariantOrder = 'error',
          },
          experimental = {
            classRegex = {
              'tw`([^`]*)',
              'tw="([^"]*)',
              'tw$begin:math:text$([^)]*)\\$end:math:text$',
              'className="([^"]*)"',
              'className={`([^`]*)`}',
            },
          },
        },
      },
    }

    lspconfig.astro.setup {
      capabilities = capabilities,
      filetypes = { 'astro' },
      root_dir = root_pattern(
        'astro.config.mjs',
        'astro.config.ts',
        'package.json',
        '.git'
      ),
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
              enabled = false,
            },
          },
        },
      },
      single_file_support = true,
    }

    lspconfig.svelte.setup {
      capabilities = capabilities,
      filetypes = { 'svelte' },
      root_dir = root_pattern(
        'svelte.config.js',
        'svelte.config.ts',
        'package.json',
        '.git'
      ),
      settings = {
        svelte = {
          plugin = {
            typescript = {
              diagnostics = { enabled = true },
            },
            eslint = {
              enabled = false,
            },
          },
        },
      },
      single_file_support = true,
    }

    lspconfig.vtsls.setup {
      capabilities = capabilities,
      filetypes = ts_filetypes,
      root_dir = root_pattern(
        'tsconfig.json',
        'jsconfig.json',
        'package.json',
        '.git'
      ),
      settings = {
        typescript = {
          inlayHints = ts_inlay_hints,
          updateImportsOnFileMove = { enabled = 'always' },
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
        local tsdk =
          vim.fs.joinpath(new_root_dir, 'node_modules', 'typescript', 'lib')
        if vim.fn.isdirectory(tsdk) == 1 then
          new_config.init_options = new_config.init_options or {}
          new_config.init_options.typescript = {
            tsdk = tsdk,
          }
        end
      end,
    }

    lspconfig.eslint.setup {
      capabilities = capabilities,
      root_dir = root_pattern(
        -- legacy config files
        '.eslintrc',
        '.eslintrc.js',
        '.eslintrc.cjs',
        '.eslintrc.json',

        -- flat config (ESLint v8+)
        'eslint.config.js',
        'eslint.config.cjs',
        'eslint.config.mjs',
        'eslint.config.ts',

        -- other common roots
        'package.json',
        '.git'
      ),
      filetypes = {
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
        'vue',
        'astro',
        'svelte',
      },
      settings = {
        format = true,
        codeAction = {
          disableRuleComment = {
            enable = true,
            location = 'separateLine',
          },
          showDocumentation = { enable = true },
        },
        lint = { run = 'onSave' },
      },
      on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
      end,
    }

    lspconfig.jsonls.setup {
      capabilities = capabilities,
      filetypes = { 'json', 'jsonc' },
      root_dir = root_pattern('.git', 'package.json'),
      settings = {
        json = {
          validate = { enable = true },
          schemaStore = {
            enable = true,
            url = 'https://www.schemastore.org/api/json/catalog.json',
          },
          schemas = {},
        },
      },
      on_new_config = function(config)
        config.settings = config.settings or {}
        config.settings.json = config.settings.json or {}

        local ok, schemastore = pcall(require, 'schemastore')
        if ok then
          local schemas = schemastore.json.schemas()
          config.settings.json.schemas = schemas
        else
          local function schema_path(name)
            return vim.fn.stdpath 'config' .. '/schemas/' .. name
          end
          config.settings.json.schemas = {
            {
              fileMatch = { '.prettierrc', '.prettierrc.json' },
              url = schema_path 'prettierrc.json',
            },
            {
              fileMatch = { 'tsconfig.json' },
              url = schema_path 'tsconfig.json',
            },
            {
              fileMatch = { '.eslintrc', '.eslintrc.json' },
              url = schema_path 'eslintrc.json',
            },
          }
        end
      end,
    }

    lspconfig.yamlls.setup {
      capabilities = capabilities,
      filetypes = { 'yaml', 'yml' },
      root_dir = root_pattern('.git', '.github', '.yaml'),
      settings = {
        yaml = {
          validate = true,
          format = {
            enable = false,
          },
          keyOrdering = false,
          schemaStore = {
            enable = false,
            url = '',
          },
          schemas = {},
        },
      },
      on_new_config = function(config)
        config.settings = config.settings or {}
        config.settings.yaml = config.settings.yaml or {}

        local ok, schemastore = pcall(require, 'schemastore')
        if ok then
          local schemas = schemastore.yaml.schemas()
          config.settings.yaml.schemas = schemas
        else
          local function schema_path(name)
            return vim.fn.stdpath 'config' .. '/schemas/' .. name
          end
          config.settings.yaml.schemas = {
            {
              description = 'GitHub Actions workflow',
              fileMatch = { '.github/workflows/*' },
              url = 'https://json.schemastore.org/github-workflow.json',
            },
            {
              description = 'YAML Lint configuration',
              fileMatch = { '.yamllint' },
              url = schema_path 'yamllint.json',
            },
          }
        end
      end,
    }

    lspconfig.emmet_language_server.setup {
      capabilities = capabilities,
      filetypes = {
        'html',
        'css',
        'scss',
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
        'svelte',
        'astro',
      },
      init_options = {
        options = {
          ['bem.enabled'] = true,
          ['output.selfClosingTag'] = true,
        },
      },
      settings = {
        html = {
          options = {
            ['bem.enabled'] = true,
            ['output.selfClosingTag'] = true,
          },
        },
        css = {
          options = {
            ['output.selfClosingTag'] = true,
          },
        },
        scss = {
          options = {
            ['output.selfClosingTag'] = true,
          },
        },
        javascript = {
          options = {
            ['output.selfClosingTag'] = false,
          },
        },
        javascriptreact = {
          options = {
            ['bem.enabled'] = false,
            ['output.selfClosingTag'] = false,
          },
        },
        typescript = {
          options = {
            ['output.selfClosingTag'] = false,
          },
        },
        typescriptreact = {
          options = {
            ['bem.enabled'] = false,
            ['output.selfClosingTag'] = false,
          },
        },
        svelte = {
          options = {
            ['bem.enabled'] = true,
            ['output.selfClosingTag'] = true,
          },
        },
        astro = {
          options = {
            ['bem.enabled'] = true,
            ['output.selfClosingTag'] = true,
          },
        },
      },
    }

    lspconfig.graphql.setup {
      capabilities = capabilities,
      filetypes = vim.tbl_extend('force', ts_filetypes, { 'graphql' }),
      root_dir = root_pattern(
        '.graphqlrc',
        '.graphqlrc.json',
        '.graphqlrc.yaml',
        '.graphqlrc.yml',
        '.graphqlrc.js',
        '.graphqlrc.ts',
        'graphql.config.json',
        'graphql.config.js',
        'graphql.config.ts',
        'package.json',
        '.git'
      ),
      single_file_support = true,
      settings = {
        graphql = {
          -- Placeholder for future options, like:
          -- schema = "<your-schema-path>",
          -- projects = { ... }
        },
      },
    }

    lspconfig.pyright.setup {
      capabilities = capabilities,
      root_dir = root_pattern(
        'pyproject.toml',
        'setup.py',
        'requirements.txt',
        '.git'
      ),
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'strict', -- Options: "off", "basic", "strict"
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'workspace',
            autoImportCompletions = true,
            stubPath = 'typings',
          },
        },
      },
    }

    lspconfig.gopls.setup {
      capabilities = capabilities,
      root_dir = root_pattern('go.work', 'go.mod', '.git'),
      settings = {
        gopls = {
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          semanticTokens = true,
          matcher = 'Fuzzy', --  Options: "Fuzzy", "CaseSensitive", or "CaseInsensitive"
          directoryFilters = { '-.git', '-node_modules', '-vendor' },
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
    }
  end,
}
