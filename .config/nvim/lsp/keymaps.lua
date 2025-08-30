local M = {}

function M.setup(bufnr)
  local wk = require 'which-key'
  local opts = { buffer = bufnr, silent = true }

  -- Which-key discoverability for LSP defaults
  wk.add({
    { 'grn', vim.lsp.buf.rename, desc = 'LSP: Rename' },
    {
      'gra',
      vim.lsp.buf.code_action,
      desc = 'LSP: Code Action',
      mode = { 'n', 'v' },
    },
    { 'grr', vim.lsp.buf.references, desc = 'LSP: References' },
    { 'gri', vim.lsp.buf.implementation, desc = 'LSP: Implementations' },
    { 'grt', vim.lsp.buf.type_definition, desc = 'LSP: Type Definition' },
    { 'gO', vim.lsp.buf.document_symbol, desc = 'LSP: Document Symbols' },
    {
      '<C-s>',
      vim.lsp.buf.signature_help,
      desc = 'LSP: Signature Help',
      mode = 'i',
    },
    { 'K', vim.lsp.buf.hover, desc = 'LSP: Hover', mode = 'n' },
  }, opts)
end

return M
