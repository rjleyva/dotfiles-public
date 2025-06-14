return {
  "mfussenegger/nvim-dap",
  lazy = true,
  keys = {
    {
      "<leader>;c",
      function()
        require("dap").continue()
      end,
      desc = "Debug: Start/Continue",
    },
    {
      "<leader>;i",
      function()
        require("dap").step_into()
      end,
      desc = "Debug: Step Into",
    },
    {
      "<leader>;o",
      function()
        require("dap").step_over()
      end,
      desc = "Debug: Step Over",
    },
    {
      "<leader>;t",
      function()
        require("dap").step_out()
      end,
      desc = "Debug: Step Out",
    },
    {
      "<leader>;b",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Debug: Toggle Breakpoint",
    },
    {
      "<leader>;B",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Debug: Set Breakpoint",
    },
    {
      "<leader>;u",
      function()
        require("dapui").toggle()
      end,
      desc = "Debug: Toggle UI",
    },
  },
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup({
          icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
          controls = {
            icons = {
              pause = "⏸",
              play = "▶",
              step_into = "⏎",
              step_over = "⏭",
              step_out = "⏮",
              step_back = "b",
              run_last = "▶▶",
              terminate = "⏹",
              disconnect = "⏏",
            },
          },
        })

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      end,
    },
    { "nvim-neotest/nvim-nio" },
    {
      "mason-org/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonLog" },
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      opts = {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {},
      },
    },
  },
  config = function()
    local dap = require("dap")

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }

    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/.bin/jest",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        trace = true,
      },
    }

    dap.configurations.typescript = dap.configurations.javascript
    dap.configurations.typescriptreact = dap.configurations.javascript
  end,
}
