local M = {}

-- Shared inlay hints for both TS/JS
local inlay_hints = {
  includeInlayParameterNameHints = 'all',
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

-- Editor preferences
local preferences = {
  importModuleSpecifier = 'relative',
  jsxAttributeCompletionStyle = 'auto',
}

M.spec = {
  cmd = {
    'vtsls',
    '--stdio',
  },

  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },

  root_markers = {
    'tsconfig.json',
    'tsconfig.base.json',
    'tsconfig.app.json',
    'tsconfig.node.json',
    'jsconfig.json',
    'package.json',
    'package-lock.json',
    'pnpm-lock.yaml',
    'pnpm-workspace.yaml',
    'yarn.lock',
    'bun.lock',
    'bun.lockb',
    '.git',
  },

  settings = {
    typescript = {
      inlayHints = inlay_hints,
      updateImportsOnFileMove = { enabled = 'always' },
      completions = { completeFunctionCalls = true },
      preferences = preferences,
    },
    javascript = {
      inlayHints = inlay_hints,
      completions = { completeFunctionCalls = true },
      preferences = preferences,
    },
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
          preferredPackageManager = 'npm',
        },
      },
    },
  },

  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
}

M.name = 'vtsls'

return M.spec
