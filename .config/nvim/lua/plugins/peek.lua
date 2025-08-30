local M = {}

-- Toggle function for peek.nvim
local function toggle_peek()
  local ok, peek = pcall(require, 'peek')
  if not ok then
    -- Native Neovim echo for notifications
    vim.api.nvim_echo({ { 'peek.nvim not loaded', 'WarningMsg' } }, true, {})
    return
  end

  -- Setup only once
  if not peek._setup_done then
    peek.setup {
      app = 'browser', -- options: webview or browser
    }
    peek._setup_done = true
  end

  -- Toggle the markdown preview
  if peek.is_open() then
    peek.close()
  else
    peek.open()
  end
end

M.spec = {
  'toppair/peek.nvim',
  build = 'deno task --quiet build:fast',

  -- Keybinding triggers lazy-loading automatically
  keys = {
    {
      '<leader>cp',
      toggle_peek,
      desc = 'Toggle Markdown Preview (Peek)',
    },
  },
}

return M.spec
