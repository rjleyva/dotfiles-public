return {
  'folke/noice.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    'rcarriga/nvim-notify',
    { 'MunifTanjim/nui.nvim', lazy = true },
  },

  opts = function()
    return {
      lsp = {
        -- disable detailed progress view in notify, prefer subtle loading message
        -- progress = {
        --   enabled = true,
        --   format = "detailed",
        --   view = "notify",
        -- },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },

      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = 'written' },
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'notify',
        },
      },

      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    }
  end,

  config = function(_, opts)
    require('noice').setup(opts)
  end,

  keys = {
    { '<leader>nn', '', desc = '+noice' },
    {
      '<S-Enter>',
      function()
        require('noice').redirect(vim.fn.getcmdline())
      end,
      mode = 'c',
      desc = 'Redirect Cmdline',
    },
    {
      '<leader>nl',
      function()
        require('noice').cmd 'last'
      end,
      desc = 'Noice Last Message',
    },
    {
      '<leader>nh',
      function()
        require('noice').cmd 'history'
      end,
      desc = 'Noice History',
    },
    {
      '<leader>na',
      function()
        require('noice').cmd 'all'
      end,
      desc = 'Noice All',
    },
    {
      '<leader>nd',
      function()
        require('noice').cmd 'dismiss'
      end,
      desc = 'Dismiss All',
    },
    {
      '<leader>np',
      function()
        require('noice').cmd 'pick'
      end,
      desc = 'Noice Picker (FzfLua)',
    },
    {
      '<C-f>',
      function()
        return require('noice.lsp').scroll(4) or '<C-f>'
      end,
      mode = { 'i', 'n', 's' },
      expr = true,
      silent = true,
      desc = 'Scroll Forward',
    },
    {
      '<C-b>',
      function()
        return require('noice.lsp').scroll(-4) or '<C-b>'
      end,
      mode = { 'i', 'n', 's' },
      expr = true,
      silent = true,
      desc = 'Scroll Backward',
    },
  },
}
