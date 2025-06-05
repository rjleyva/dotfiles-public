return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  keys = {
    {
      "<leader>ee",
      "<cmd>Neotree toggle<cr>",
      desc = "Toggle Neo-tree sidebar",
    },
    {
      "<leader>ec",
      function()
        local reveal_file = vim.fn.expand("%:p")
        if reveal_file == "" or vim.uv.fs_stat(reveal_file) == nil then
          reveal_file = vim.fn.getcwd()
        end

        require("neo-tree.command").execute({
          action = "focus",
          source = "filesystem",
          position = "right",
          reveal_file = reveal_file,
          reveal_force_cwd = true,
        })
      end,
      desc = "Reveal current file in Neo-tree",
    },
  },
  opts = {
    sources = { "filesystem", "buffers", "git_status" },
    filesystem = {
      window = {
        position = "right",
      },
    },
    buffers = {
      window = {
        position = "right",
      },
    },
    git_status = {
      window = {
        position = "right",
      },
    },
  },
}
