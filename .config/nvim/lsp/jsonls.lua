local M = {}

M.spec = {
  cmd = {
    'vscode-json-language-server',
    '--stdio',
  },

  filetypes = {
    'json',
    'jsonc',
  },

  root_markers = {
    '.git',
    'package.json',
    'tsconfig.json',
    'jsconfig.json',
  },

  settings = {
    json = {
      validate = { enable = true },
      format = { enable = true },
      schemas = require('schemastore').json.schemas(), -- auto-completion from schemastore
      schemaDownload = { enable = true },
    },
  },

  single_file_support = true,

  log_level = vim.lsp.protocol.MessageType.Warning,
}

M.name = 'jsonls'

return M.spec
