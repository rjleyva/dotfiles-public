return {
  "kylechui/nvim-surround",
  version = "*",
  -- event = { "BufReadPre", "BufNewFile" }, -- use BufReadPre/BufNewFile for earlier loading
  event = "VeryLazy",
  opts = {
    keymaps = {
      normal = "ys",
      normal_cur = "yss",
      normal_line = "yS",
      normal_cur_line = "ySS",
      visual = "S",
      visual_line = "gS",
      delete = "ds",
      change = "cs",
    },
  },
}
