--[[
  GraphQL LSP configuration (Neovim 0.11.3+)

  Notes:
  - The filetypes 'astro', 'svelte', and 'vue' are commented out for now because most of my projects do not use GraphQL
    within these frameworks. Keeping them commented prevents unnecessary LSP processing, false diagnostics, and improves
    start-up performance.

	-	The documentSelector lines are commented out because, at present, I only want the GraphQL LSP to handle standard
    .graphql files and JavaScript/TypeScript React files. If a project later uses GraphQL within .astro, .svelte, or .vue
    files, these lines can be uncommented and adjusted on a per-project basis.

  - Currently commented to avoid scanning unnecessary files.
]]

local M = {}

M.spec = {
  cmd = {
    'graphql-lsp',
    'server',
    '-m',
    'stream',
  },

  filetypes = {
    'graphql',
    'typescriptreact',
    'javascriptreact',
    'typescript',
    'javascript',
    -- 'astro',
    -- 'svelte',
    -- 'vue',
  },

  root_markers = {
    '.git',
    -- GraphQL config files
    '.graphqlrc',
    '.graphqlrc.json',
    '.graphqlrc.yaml',
    '.graphqlrc.yml',
    '.graphqlrc.js',
    'graphql.config.json',
    'graphql.config.js',
    'graphql.config.yaml',
    'graphql.config.yml',
  },

  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,

  -- documentSelector = {
  --   { language = 'graphql', scheme = 'file' },
  --   { language = 'graphql', scheme = 'file', pattern = '**/*.astro' },
  -- },
}

M.name = 'graphql'

return M.spec
