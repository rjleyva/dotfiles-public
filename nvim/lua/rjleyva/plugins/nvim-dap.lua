-- WIP: This configuration builds on the solid foundation of kickstart.nvim.
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/lua/kickstart/plugins/debug.lua
-- I regularly explore both kickstart and LazyVim to learn from their best practices,
-- and gradually adapt those ideas into my own setup.
-- Some parts of the Go adapter config are still under development
return {
  'mfussenegger/nvim-dap',
  lazy = true,
  keys = {
    {
      '<leader>;c',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<leader>;i',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<leader>;S',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<leader>;s',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>;b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>;B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    {
      '<leader>;t',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: Toggle UI',
    },
  },
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        dapui.setup {
          icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
          controls = {
            icons = {
              pause = '⏸',
              play = '▶',
              step_into = '⏎',
              step_over = '⏭',
              step_out = '⏮',
              step_back = 'b',
              run_last = '▶▶',
              terminate = '⏹',
              disconnect = '⏏',
            },
          },
        }

        dap.listeners.after.event_initialized['dapui_config'] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
          dapui.close()
        end
      end,
    },
    { 'nvim-neotest/nvim-nio' },
    {
      'mason-org/mason.nvim',
    },
    {
      'jay-babu/mason-nvim-dap.nvim',
      opts = {
        ensure_installed = {
          'js',
          'debugpy',
          'delve',
        },
        automatic_installation = true,
        handlers = {
          function(config)
            require('mason-nvim-dap').default_setup(config)
          end,
        },
      },
    },
    {
      'leoluz/nvim-dap-go',
      config = function()
        require('dap-go').setup {
          delve = {
            detached = vim.fn.has 'win32' == 0,
          },
          dap_configurations = {
            {
              type = 'go',
              name = 'Debug current file',
              request = 'launch',
              program = '${file}',
            },
            {
              type = 'go',
              name = 'Debug file with arguments',
              request = 'launch',
              program = '${file}',
              args = function()
                local input = vim.fn.input 'Args: '
                return vim.fn.split(input, ' ', true)
              end,
            },
            {
              type = 'go',
              name = 'Attach to running process (port 3000)',
              mode = 'remote',
              request = 'attach',
              connect = { host = '127.0.0.1', port = 3000 },
            },
          },
        }
      end,
    },
  },

  config = function()
    local dap = require 'dap'

    -- JavaScript/TypeScript (pwa-node)
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = {
          vim.fn.stdpath 'data'
            .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
          '${port}',
        },
      },
    }

    dap.configurations.javascript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Debug Jest Tests',
        runtimeExecutable = 'node',
        runtimeArgs = {
          './node_modules/.bin/jest',
          '--runInBand',
        },
        rootPath = '${workspaceFolder}',
        cwd = '${workspaceFolder}',
        console = 'integratedTerminal',
        internalConsoleOptions = 'neverOpen',
        trace = true,
      },
    }

    dap.configurations.typescript = dap.configurations.javascript
    dap.configurations.typescriptreact = dap.configurations.javascript

    -- Python (debugpy)
    dap.adapters.python = {
      type = 'executable',
      command = 'python',
      args = { '-m', 'debugpy.adapter' },
    }

    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = function()
          local venv_path = os.getenv 'VIRTUAL_ENV'
          return venv_path and (venv_path .. '/bin/python') or 'python'
        end,
      },
    }
  end,
}
