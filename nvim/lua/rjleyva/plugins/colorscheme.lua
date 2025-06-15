return {
  'craftzdog/solarized-osaka.nvim',
  lazy = true,
  priority = 1000,
  event = 'VeryLazy',
  opts = {
    use_background = 'dark',
    border = 'rounded',
    enable_italics = true,
    style = 'dark',
    transparent = true,
    terminal_colors = true,
    styles = {
      boolean = { bold = true },
      comments = { italic = true },
      conditionals = { italic = true },
      functions = { bold = true },
      keywords = { bold = true, italic = false },
      loops = { italic = true },
      misc = { italic = true },
      numbers = { bold = true },
      operators = { bold = true },
      properties = { italic = true },
      string = { bold = true },
      types = { bold = true },
      variables = { bold = false },
      underline = true,
      undercurl = true,
    },
  },
  config = function(_, opts)
    require('solarized-osaka').setup(opts)
    vim.cmd.colorscheme 'solarized-osaka'
    vim.schedule(function()
      vim.api.nvim_set_hl(0, 'Visual', { reverse = true })
    end)
  end,
}
