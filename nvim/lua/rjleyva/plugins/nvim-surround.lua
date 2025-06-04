return {
  version = "v3.1.2",
  "kylechui/nvim-surround",
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
