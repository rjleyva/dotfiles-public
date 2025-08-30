local M = {}

M.spec = {
  cmd = {
    'vscode-css-language-server',
    '--stdio',
  },

  filetypes = {
    'css',
    'scss',
    'less',
  },

  root_markers = {
    'package.json',
    'postcss.config.js',
    'postcss.config.cjs',
    '.git',
    -- Optional, useful if you want Tailwind intellisense support:
    -- 'tailwind.config.js',
    -- 'tailwind.config.cjs',
  },

  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = 'ignore',
      },
    },
    scss = { validate = true },
    less = { validate = true },

    -- BEM methodology:
    -- Keep validation enabled, but avoid false positives from
    -- unknown selectors/properties (e.g. .block__element--modifier).
    customData = {}, -- Extend later with custom completions if needed
  },

  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}

M.name = 'cssls'

return M.spec
