return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Load the colorscheme
    vim.cmd([[colorscheme solarized-osaka]])

    -- Default Settings for solarized-osaka
    require("solarized-osaka").setup({
      style = "dark",
      transparent = true,
      terminal_colors = true,
      enable_italics = false,
      styles = {
        -- Style to be applied to different syntax groups
        comments = { italic = true },
        keywords = { italic = false },
        functions = { bold = true },
        variables = { italic = true },
        string = { italic = false },
        underline = true,
        undercurl = true,
      },
    })
  end,
}
