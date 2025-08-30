local M = {}

M.spec = {
  cmd = {
    'marksman',
    'server',
  },

  filetypes = {
    'markdown',
    'markdown.mdx',
  },

  root_markers = {
    '.marksman.toml',
    'mkdocs.yml',
    'docs',
    '_docs',
    '.git',
  },

  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}

M.name = 'marksman'

return M.spec
