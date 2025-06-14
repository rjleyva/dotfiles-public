return {
  "rest-nvim/rest.nvim",
  ft = { "http" },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  init = function()
    vim.filetype.add({
      extension = {
        http = "http",
      },
    })
  end,

  opts = {
    custom_dynamic_variables = {},
    request = {
      skip_ssl_verification = true,
      hooks = {
        encode_url = true,
        user_agent = "rest.nvim",
        set_content_type = true,
      },
    },
    response = {
      hooks = {
        decode_url = true,
        format = true,
      },
    },
    clients = {
      curl = {
        statistics = {
          { id = "time_total", title = "Time taken" },
          { id = "size_download", title = "Download size" },
        },
        opts = {
          set_compressed = false,
          certificates = {},
        },
      },
    },
    cookies = {
      enable = true,
      path = vim.fs.joinpath(vim.fn.stdpath("data"), "rest-nvim.cookies"),
    },
    env = {
      enable = true,
      pattern = ".*%.env.*",
      find = function()
        local config = require("rest-nvim.config")
        return vim.fs.find(function(name, _)
          return name:match(config.env.pattern)
        end, {
          path = vim.fn.getcwd(),
          type = "file",
          limit = math.huge,
        })
      end,
    },
    ui = {
      winbar = true,
      keybinds = {
        prev = "H",
        next = "L",
      },
    },
    highlight = {
      enable = true,
      timeout = 750,
    },
    _log_level = vim.log.levels.WARN,
  },

  config = function(_, opts)
    -- NOTE:
    -- Intentionally using deprecated setup.
    -- Switching to `vim.g.rest_nvim` causes a module not found error.
    -- Keeping the deprecation warning visible as a reminder — still working on a proper fix.
    require("rest-nvim").setup(opts)
    vim.keymap.set("n", "\\r", "<cmd>Rest run<CR>", { desc = "Run HTTP request" })
  end,
}
