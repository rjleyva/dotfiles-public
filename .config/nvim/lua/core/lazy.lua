local M = {}

M.setup = function()
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

  if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazypath,
    }
  end

  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup({
    { import = 'plugins' },
  }, {
    defaults = {
      lazy = true,
      version = false,
    },

    checker = {
      enabled = true,
      notify = false,
    },

    change_detection = {
      enabled = true,
      notify = false,
    },

    performance = {
      -- cache = { enabled = true },
      rtp = {
        disabled_plugins = {
          'matchit',
          'matchparen',
          -- 'netrwPlugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'gzip',
          'zipPlugin',
        },
      },
    },
  })
end

return M
