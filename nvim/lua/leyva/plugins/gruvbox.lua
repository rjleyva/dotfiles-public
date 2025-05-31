return {
  "morhetz/gruvbox",
  lazy = false,
  priority = 1000,
  config = function()
    local transparent = true

    vim.o.background = "dark"
    vim.g.gruvbox_italic = 1
    vim.g.gruvbox_italicize_comments = 1
    vim.g.gruvbox_italicize_strings = 1
    -- vim.g.gruvbox_improved_strings = 1
    vim.g.gruvbox_italicize_keywords = 1
    vim.g.gruvbox_bold = 1

    vim.cmd.colorscheme("gruvbox")

    local hl = vim.api.nvim_set_hl
    if transparent then
      hl(0, "Normal", { bg = "none" })
      hl(0, "NormalNC", { bg = "none" })
      hl(0, "NormalFloat", { bg = "none" })
      hl(0, "FloatBorder", { bg = "none" })
      hl(0, "SignColumn", { bg = "none" })
      hl(0, "VertSplit", { bg = "none" })
    end
  end,
}
