return {
  "MeanderingProgrammer/render-markdown.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
  ft = { "markdown" },
  opts = {
    html = { enabled = false },
    latex = { enabled = false },
  },
}
