return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    use_background = "dark",
    border = "rounded",
    enable_italics = true,
    style = "dark",
    transparent = true,
    terminal_colors = true,
    styles = {
      boolean = { bold = true },
      comments = { bold = true },
      conditionals = { italic = true },
      functions = { bold = true },
      keywords = { bold = true },
      loops = { italic = true },
      misc = { italic = true },
      numbers = { bold = true },
      operators = { bold = true },
      properties = { italic = true },
      string = { bold = false },
      types = { italic = true },
      underline = true,
      undercurl = true,
      variables = { italic = true },
    },
  },
  config = function(_, opts)
    require("solarized-osaka").setup(opts)
    vim.cmd.colorscheme("solarized-osaka")
    vim.api.nvim_set_hl(0, "Visual", { reverse = true })
  end,
}
