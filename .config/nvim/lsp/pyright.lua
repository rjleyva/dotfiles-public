local M = {}

M.spec = {
  cmd = {
    'pyright-langserver',
    '--stdio',
  },

  filetypes = { 'python' },

  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },

  settings = {
    python = {
      analysis = {
        -- Core analysis
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = 'workspace', -- analyze all files in workspace
        useLibraryCodeForTypes = true,

        -- Strict type checking
        typeCheckingMode = 'strict',

        -- Inlay hints
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
          callArgumentNames = true,
          genericTypes = true,
        },

        -- Override severities (strict = turn many into errors)
        diagnosticSeverityOverrides = {
          reportMissingImports = 'error',
          reportMissingTypeStubs = 'warning', -- keep warning, otherwise noisy
          reportUndefinedVariable = 'error',
          reportUnusedVariable = 'error',
          reportUnusedImport = 'error',
          reportUnusedFunction = 'error',
          reportUnusedClass = 'error',
          reportGeneralTypeIssues = 'error',
          reportOptionalMemberAccess = 'error',
          reportOptionalSubscript = 'error',
          reportOptionalCall = 'error',
          reportUntypedFunctionDecorator = 'warning',
          reportUntypedNamedTuple = 'warning',
          reportUnknownMemberType = 'warning',
        },
      },
    },
  },

  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}

M.name = 'pyright'

return M.spec
