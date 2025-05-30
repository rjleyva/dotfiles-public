-- https://github.com/nikolovlazar/dotfiles/blob/6c580d1e360f23aa4414516f73c5779a307b4e2e/.config/nvim/lua/plugins/dap.lua

return {
  {
    "mfussenegger/nvim-dap",
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
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      virt_text_win_col = 80,
    },
  },
}
