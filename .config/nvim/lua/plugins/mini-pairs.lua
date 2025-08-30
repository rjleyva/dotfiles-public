local M = {}

M.spec = {
  'echasnovski/mini.pairs',
  version = '*',
  event = 'InsertEnter',

  opts = {
    modes = { insert = true, command = true, terminal = false },
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    skip_ts = { 'string' },
    skip_unbalanced = true,
    markdown = true,
    mappings = {
      ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
      ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
      ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

      [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
      [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
      ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

      ['"'] = {
        action = 'closeopen',
        pair = '""',
        neigh_pattern = '[^\\].',
        register = { cr = false },
      },

      ["'"] = {
        action = 'closeopen',
        pair = "''",
        neigh_pattern = '[^%a\\].',
        register = { cr = false },
      },

      ['`'] = {
        action = 'closeopen',
        pair = '``',
        neigh_pattern = '[^\\].',
        register = { cr = false },
      },
    },
  },
}

return M.spec
