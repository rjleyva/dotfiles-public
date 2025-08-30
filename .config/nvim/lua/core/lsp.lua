-- LSP paths
local config_dir = vim.fn.stdpath 'config'
package.path = table.concat({
  config_dir .. '/?.lua',
  config_dir .. '/?/init.lua',
  package.path,
}, ';')

-- LSP servers
vim.lsp.enable {
  'astro',
  'cssls',
  'emmet-language-server',
  'gopls',
  'graphql',
  'html',
  'jsonls',
  'lua_ls',
  'marksman',
  'pyright',
  'vtsls',
  'yamlls',
}

-- On LSP attach
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP setup',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    local bufnr = args.buf

    -- Capabilities (nvim-cmp)
    local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    if ok then
      client.server_capabilities = vim.tbl_deep_extend(
        'force',
        client.server_capabilities or {},
        cmp_nvim_lsp.default_capabilities() or {}
      )
    end

    -- Inlay hints
    if
      client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint)
    then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Keymaps
    require('lsp.keymaps').setup(bufnr)
  end,
})

-- Diagnostics
vim.diagnostic.config {
  virtual_lines = true,
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,

  float = {
    border = 'rounded',
    source = true,
  },

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
}
