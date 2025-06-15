return {
  'nvim-neotest/neotest',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'antoinemadec/FixCursorHold.nvim', lazy = true },
    { 'nvim-treesitter/nvim-treesitter', lazy = true },
    { 'nvim-neotest/neotest-jest', lazy = true },
    { 'nvim-neotest/neotest-plenary', lazy = true },
    { 'nvim-neotest/nvim-nio', lazy = true },
  },
  keys = {
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Run File',
    },
    {
      '<leader>tr',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run Nearest',
    },
    {
      '<leader>ta',
      function()
        require('neotest').run.run(vim.loop.cwd())
      end,
      desc = 'Run All Tests',
    },
    {
      '<leader>tl',
      function()
        require('neotest').run.run_last()
      end,
      desc = 'Run Last',
    },
    {
      '<leader>tt',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle Summary',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open { enter = true, auto_close = true }
      end,
      desc = 'Show Output',
    },
    {
      '<leader>tp',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = 'Toggle Output Panel',
    },
    {
      '<leader>ts',
      function()
        require('neotest').run.stop()
      end,
      desc = 'Stop Tests',
    },
  },
  opts = function()
    local get_jest_config = function()
      local file = vim.fn.expand '%:p'
      if file:find '/packages/' then
        return file:match '(.-/[^/]+/)src' .. 'jest.config.ts'
      end
      return vim.fn.getcwd() .. '/jest.config.ts'
    end

    local get_cwd = function()
      local file = vim.fn.expand '%:p'
      if file:find '/packages/' then
        return file:match '(.-/[^/]+/)src'
      end
      return vim.fn.getcwd()
    end

    return {
      adapters = {
        require 'neotest-plenary',

        require 'neotest-jest' {
          jestConfigFile = get_jest_config,
          cwd = get_cwd,
        },
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          local has_trouble, trouble = pcall(require, 'trouble')
          if has_trouble then
            trouble.open { mode = 'quickfix', focus = false }
          else
            vim.cmd 'copen'
          end
        end,
      },
    }
  end,

  config = function(_, opts)
    require('neotest').setup(opts)

    local ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          return (
            diagnostic.message
              :gsub('\n', ' ')
              :gsub('\t', ' ')
              :gsub('%s+', ' ')
              :gsub('^%s+', '')
          )
        end,
      },
    }, ns)
  end,
}
