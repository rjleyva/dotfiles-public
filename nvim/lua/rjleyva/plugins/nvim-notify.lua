return {
  "rcarriga/nvim-notify",
  lazy = false,
  opts = {
    timeout = 7000,
    stages = "static",
  },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify
  end,
}
