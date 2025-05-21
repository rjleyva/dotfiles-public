return {
  "rcarriga/nvim-notify",
  version = "*",
  event = "VeryLazy",
  opts = {
    timeout = 3000,
    stages = "static",
    on_open = function()
      local border_color = "#98971a"

      local levels = { "ERROR", "WARN", "INFO", "DEBUG", "TRACE" }

      for _, level in ipairs(levels) do
        vim.api.nvim_set_hl(0, "Notify" .. level .. "Icon", { fg = border_color })
        vim.api.nvim_set_hl(0, "Notify" .. level .. "Title", { fg = border_color })
        vim.api.nvim_set_hl(0, "Notify" .. level .. "Border", { fg = border_color })
        vim.api.nvim_set_hl(0, "Notify" .. level .. "Body", { link = "Normal" })
      end
    end,
  },
  config = function(_, opts)
    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify
    vim.cmd("doautocmd ColorScheme")
  end,
}
