return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  config = function(_, _)
    require('harpoon'):setup()
  end,
  keys = {
    -- Add file to Harpoon
    {
      '<leader>ha',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Harpoon: Add file',
    },
    -- Harpoon: Remove current file
    {
      '<leader>hd',
      function()
        require('harpoon'):list():remove()
      end,
      desc = 'Harpoon: Remove current file',
    },
    -- Harpoon: Toggle built-in menu
    {
      '<C-e>',
      function()
        require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
      end,
      desc = 'Harpoon: Toggle menu',
    },
    -- Quick navigation with Ctrl keys
    {
      '<C-h>',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'Harpoon: Go to file 1',
    },
    {
      '<C-j>',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'Harpoon: Go to file 2',
    },
    {
      '<C-k>',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'Harpoon: Go to file 3',
    },
    {
      '<C-l>',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'Harpoon: Go to file 4',
    },
    --  Numbered navigation
    {
      '<leader>h0',
      function()
        require('harpoon'):list():select(0)
      end,
      desc = 'Harpoon: Go to file 0',
    },
    {
      '<leader>h1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'Harpoon: Go to file 1',
    },
    {
      '<leader>h2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'Harpoon: Go to file 2',
    },
    {
      '<leader>h3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'Harpoon: Go to file 3',
    },
    {
      '<leader>h4',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'Harpoon: Go to file 4',
    },
    {
      '<leader>h5',
      function()
        require('harpoon'):list():select(5)
      end,
      desc = 'Harpoon: Go to file 5',
    },
    {
      '<leader>h6',
      function()
        require('harpoon'):list():select(6)
      end,
      desc = 'Harpoon: Go to file 6',
    },
    {
      '<leader>h7',
      function()
        require('harpoon'):list():select(7)
      end,
      desc = 'Harpoon: Go to file 7',
    },
    {
      '<leader>h8',
      function()
        require('harpoon'):list():select(8)
      end,
      desc = 'Harpoon: Go to file 8',
    },
    {
      '<leader>h9',
      function()
        require('harpoon'):list():select(9)
      end,
      desc = 'Harpoon: Go to file 9',
    },
    -- FZF-Lua: fuzzy jump to any Harpoon file
    {
      '<leader>hf',
      function()
        local harpoon = require 'harpoon'
        local fzf = require 'fzf-lua'
        local list = harpoon:list()
        local entries = {}
        for i, item in ipairs(list.items) do
          table.insert(entries, i .. ': ' .. item.value)
        end

        fzf.fzf_exec(entries, {
          prompt = 'Harpoon > ',
          actions = {
            ['default'] = function(selected)
              local line = selected[1]
              local index = tonumber(line:match '^(%d+):')
              if index then
                list:select(index)
              end
            end,
          },
        })
      end,
      desc = 'FZF Harpoon: Fuzzy jump to mark',
    },
  },
}
