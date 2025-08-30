local M = {}

local schemastore = require 'schemastore'

M.spec = {
  cmd = {
    'yaml-language-server',
    '--stdio',
  },

  filetypes = {
    'yaml',
    'yml',
  },

  root_markers = {
    '.yamllint',
    '.git',
    'package.json',
    'docker-compose.yml',
    'docker-compose.yaml',
  },

  settings = {
    yaml = {
      validate = true,
      format = { enable = true },
      hover = true,
      completion = true,
      schemaStore = {
        enable = false, -- disable built-in, use schemastore.nvim instead
        url = '',
      },
      schemas = schemastore.yaml.schemas(), -- auto-load schemas
      customTags = {
        '!Ref scalar',
        '!Sub scalar',
        '!GetAtt scalar',
        '!ImportValue scalar',
        '!Join sequence',
        '!Select sequence',
        '!If sequence',
      },
    },
  },

  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}

M.name = 'yamlls'

return M.spec
