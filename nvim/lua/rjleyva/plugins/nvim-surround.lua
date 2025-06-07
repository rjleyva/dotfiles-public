return {
  "kylechui/nvim-surround",
  version = "v3.1.2",
  event = "InsertEnter",
  opts = {},
  keys = {
    { "sm", desc = "Add surrounding (manual input)", mode = "n" },
    { "sy", desc = "Add surrounding to current word", mode = "n" },
    { "sl", desc = "Add surrounding to current line", mode = "n" },
    { "sY", desc = "Add surrounding to entire line", mode = "n" },
    { "s", desc = "Add surrounding in visual mode", mode = "v" },
    { "sg", desc = "Add surrounding to visual lines", mode = "v" },
    { "sd", desc = "Delete surrounding", mode = "n" },
    { "sc", desc = "Change surrounding", mode = "n" },
  },

  config = function(_, _)
    require("nvim-surround").setup({
      keymaps = {
        normal = "sm",
        normal_cur = "sy",
        normal_line = "sl",
        normal_cur_line = "sY",
        visual = "s",
        visual_line = "sg",
        delete = "sd",
        change = "sc",
      },
    })
  end,
}
