local M = {}

function M.general()
  vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode' })
  vim.keymap.set('n', '<leader>+', '<C-a>', { desc = 'Increment number' })
  vim.keymap.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' })
  vim.keymap.set('n', '<leader>n', '<cmd>enew<CR>', { desc = 'New buffer' })
  vim.keymap.set(
    'n',
    '<leader>o',
    ':update<CR>:source<CR>',
    { desc = 'Source & Reload file' }
  )
end

function M.files()
  vim.keymap.set('n', '\\', function()
    local netrw_open = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if
        vim.api.nvim_buf_is_loaded(buf)
        and vim.api.nvim_buf_get_name(buf):match 'NetrwTreeListing'
      then
        netrw_open = buf
        break
      end
    end

    if netrw_open then
      vim.api.nvim_buf_delete(netrw_open, { force = true })
    else
      vim.cmd.Ex()
    end
  end, { desc = 'Toggle netrw file explorer' })

  vim.keymap.set(
    'n',
    '<leader>fb',
    ':ls<CR>:b',
    { desc = 'Switch buffer (native)' }
  )
end

function M.navigation()
  local function nvim_tmux_nav(direction, tmux_direction)
    local cur_win = vim.api.nvim_get_current_win()
    vim.cmd('wincmd ' .. direction)
    if vim.api.nvim_get_current_win() == cur_win then
      vim.fn.system { 'tmux', 'select-pane', '-' .. tmux_direction }
    end
  end

  vim.keymap.set('n', '<C-h>', function()
    nvim_tmux_nav('h', 'L')
  end, { desc = 'Move left split/pane' })
  vim.keymap.set('n', '<C-j>', function()
    nvim_tmux_nav('j', 'D')
  end, { desc = 'Move down split/pane' })
  vim.keymap.set('n', '<C-k>', function()
    nvim_tmux_nav('k', 'U')
  end, { desc = 'Move up split/pane' })
  vim.keymap.set('n', '<C-l>', function()
    nvim_tmux_nav('l', 'R')
  end, { desc = 'Move right split/pane' })

  vim.keymap.set('n', '<leader>ff', ':find ', { desc = 'Find file (native)' })
  vim.keymap.set('n', '<leader>fg', function()
    local keyword = vim.fn.input 'grep: '
    if keyword ~= '' then
      vim.cmd('silent grep! ' .. vim.fn.shellescape(keyword) .. ' **/*')
      vim.cmd 'copen'
    end
  end, { desc = 'Grep project (native)' })
  vim.keymap.set(
    'n',
    '<leader>fa',
    ':args **/*<CR>',
    { desc = 'Load arglist (all project files)' }
  )
end

function M.quickfix()
  vim.keymap.set('n', ']q', '<cmd>cnext<CR>zz', { desc = 'Next quickfix' })
  vim.keymap.set('n', '[q', '<cmd>cprev<CR>zz', { desc = 'Prev quickfix' })
  vim.keymap.set(
    'n',
    '<leader>qo',
    '<cmd>copen<CR>',
    { desc = 'Open quickfix' }
  )
  vim.keymap.set(
    'n',
    '<leader>qc',
    '<cmd>cclose<CR>',
    { desc = 'Close quickfix' }
  )
end

function M.diagnostics()
  vim.keymap.set(
    'n',
    '[d',
    vim.diagnostic.goto_prev,
    { desc = 'Diagnostics: Prev' }
  )
  vim.keymap.set(
    'n',
    ']d',
    vim.diagnostic.goto_next,
    { desc = 'Diagnostics: Next' }
  )
  vim.keymap.set(
    'n',
    '<leader>xq',
    vim.diagnostic.setqflist,
    { desc = 'Diagnostics: Quickfix' }
  )
  vim.keymap.set(
    'n',
    '<leader>xl',
    vim.diagnostic.setloclist,
    { desc = 'Diagnostics: Location List' }
  )
  vim.keymap.set(
    'n',
    '<leader>xf',
    vim.diagnostic.open_float,
    { desc = 'Diagnostics: Float' }
  )

  vim.keymap.set('n', '<leader>xd', function()
    if vim.diagnostic.is_disabled(0) then
      vim.diagnostic.enable(0)
      vim.notify 'Diagnostics enabled (buffer)'
    else
      vim.diagnostic.disable(0)
      vim.notify 'Diagnostics disabled (buffer)'
    end
  end, { desc = 'Diagnostics: Toggle Buffer' })

  vim.keymap.set('n', '<leader>xt', function()
    local current = vim.diagnostic.config().virtual_text
    vim.diagnostic.config { virtual_text = not current }
    vim.notify('Diagnostics virtual text: ' .. (current and 'OFF' or 'ON'))
  end, { desc = 'Diagnostics: Toggle Virtual Text' })
end

function M.inspect()
  vim.keymap.set('n', '<leader>i', vim.show_pos, { desc = 'Inspect Pos' })
  vim.keymap.set('n', '<leader>O', function()
    vim.treesitter.inspect_tree()
    vim.api.nvim_input 'I'
  end, { desc = 'Inspect Tree' })

  vim.keymap.set(
    'n',
    '<leader>cm',
    '<cmd>messages<CR>',
    { desc = 'Show messages' }
  )
  vim.keymap.set(
    'n',
    '<leader>ch',
    '<cmd>checkhealth<CR>',
    { desc = 'Checkhealth' }
  )
end

function M.plugins()
  vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Lazy' })
  vim.keymap.set(
    'n',
    '<leader>cs',
    ':nohl<CR>',
    { desc = 'Clear search highlights' }
  )
end

function M.quit()
  vim.keymap.set('n', '<leader>cq', '<cmd>qa<CR>', { desc = 'Exit/Quit all' })
end

function M.setup()
  M.general()
  M.files()
  M.navigation()
  M.quickfix()
  M.diagnostics()
  M.inspect()
  M.plugins()
  M.quit()
end

return M
