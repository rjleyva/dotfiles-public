local M = {}

local function augroup(name)
  return vim.api.nvim_create_augroup('rj_autocmnd_' .. name, { clear = true })
end

-- https://www.lazyvim.org/configuration/general

function M.setup()
  -- Highlight on yank
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup 'highlight_on_yank',
    desc = 'Highlight yanked text',
    callback = function()
      vim.hl.on_yank { timeout = 150 }
    end,
  })

  -- Auto create parent directory before saving file
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup 'auto_create_parent_dir',
    desc = 'Auto-create parent directories on save',
    callback = function(event)
      if event.match:match '^%a%a+://' then
        return
      end
      local filepath = vim.uv.fs_realpath(event.match) or event.match
      local parent = vim.fn.fnamemodify(filepath, ':p:h')
      if not vim.uv.fs_stat(parent) then
        vim.fn.mkdir(parent, 'p')
      end
    end,
  })

  -- Enable wrap/spell for text filetypes
  vim.api.nvim_create_autocmd('FileType', {
    group = augroup 'text_wrap_spell',
    desc = 'Enable wrap and spell for writing filetypes',
    pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

  -- close certain buffers with <q>, safely
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
    pattern = {
      'PlenaryTestPopup',
      'checkhealth',
      'dbout',
      'gitsigns-blame',
      'help',
      'lspinfo',
      -- 'neotest-output',
      -- 'neotest-output-panel',
      -- 'neotest-summary',
      'notify',
      'qf',
      'spectre_panel',
      'startuptime',
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set('n', 'q', function()
        if vim.fn.winnr '$' > 1 then
          vim.cmd 'close'
        else
          vim.cmd 'bdelete'
        end
      end, { buffer = event.buf, silent = true })
    end,
  })

  -- https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/lua/config/autocmds.lua

  -- Fix conceallevel for JSON
  vim.api.nvim_create_autocmd('FileType', {
    group = augroup 'json_conceal_fix',
    desc = 'Disable conceal for JSON files',
    pattern = { 'json', 'jsonc', 'json5' },
    callback = function()
      vim.opt_local.conceallevel = 0
    end,
  })
end

return M
