return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
    },
    keys = {
      {
        ";dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        ";do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        ";di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        ";dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        ";db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        ";dr",
        function()
          require("dap").repl.open()
        end,
        desc = "Open REPL",
      },
    },
    config = function()
      local dap = require("dap")

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = 3000,
        executable = {
          command = "js-debug-adapter",
          args = { "--stdio" },
        },
      }

      for _, lang in ipairs({ "javascript", "typescript" }) do
        dap.configurations[lang] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
          },
        }
      end

      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        require("dapui").close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        require("dapui").close()
      end
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      virt_text_win_col = 80,
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    opts = {},
  },
}
