local M = {}

M.spec = {
  cmd = {
    'lua-language-server',
  },

  filetypes = {
    'lua',
  },

  root_markers = {
    '.git',
    '.luacheckrc',
    '.luarc.json',
    '.luarc.jsonc',
    '.stylua.toml',
    'selene.toml',
    'selene.yml',
  },

  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      hint = {
        enable = true,
        setType = true,
        paramType = true,
        paramName = 'All',
        semicolon = 'All',
        arrayIndex = 'All',
        moduleName = 'All',
      },
      telemetry = {
        enable = false,
      },
      workspace = {
        checkThirdParty = false,
        library = {},

        -- Enable this if you want:
        -- Full API docs and completion for plugin development
        -- Autocompletion for all vim.api.* functions
        -- Uncomment the line below to index Neovim’s runtime and plugins:
        -- library = vim.api.nvim_get_runtime_file(),
      },
    },
  },

  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
}

M.name = 'lua_ls'

return M.spec
