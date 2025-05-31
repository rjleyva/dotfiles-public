-- https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/dap.lua
-- If you want to learn more about this plugin, I highly recommend watching this TJ DeVries YouTube video
-- [simple neovim debugging setup (in 10 minutes)](https://www.youtube.com/watch?v=lyNfnI-B640)

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "mxsdev/nvim-dap-vscode-js",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dapui").setup()

      require("nvim-dap-virtual-text").setup({
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
            return "*****"
          end
          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end
          return " " .. variable.value
        end,
      })

      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal" },
      })

      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome to debug client",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Node backend",
            program = "${workspaceFolder}/server.js",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Node process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch TS backend",
            program = "${workspaceFolder}/server.ts",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "npx",
            runtimeArgs = { "ts-node" },
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Next.js backend",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            protocol = "inspector",
            skipFiles = { "<node_internals>/**" },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Test (DAP)",
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "${file}",
              "--runInBand",
              "--testTimeout=10000",
              "--no-cache",
              "--detectOpenHandles",
              "--forceExit",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
          },
        }
      end

      vim.keymap.set("n", "<space>dtb", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      vim.keymap.set("n", "<space>drc", dap.run_to_cursor, { desc = "DAP: Run to Cursor" })
      vim.keymap.set("n", "<space>das", function()
        dapui.eval(nil, { enter = true })
      end, { desc = "DAP: Eval Variable Under Cursor" })
      vim.keymap.set("n", "<space>du", dapui.toggle, { desc = "DAP: Toggle UI" })

      vim.keymap.set("n", ";c", dap.continue, { desc = "DAP: Continue" })
      vim.keymap.set("n", ";si", dap.step_into, { desc = "DAP: Step Into" })
      vim.keymap.set("n", ";sO", dap.step_over, { desc = "DAP: Step Over" })
      vim.keymap.set("n", ";so", dap.step_out, { desc = "DAP: Step Out" })
      vim.keymap.set("n", ";sb", dap.step_back, { desc = "DAP: Step Back" })
      vim.keymap.set("n", ";rt", dap.restart, { desc = "DAP: Restart" })

      vim.keymap.set("n", ";td", function()
        require("neotest").run.run({ strategy = "dap" })
      end, { desc = "Neotest: Debug Nearest Test" })

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
