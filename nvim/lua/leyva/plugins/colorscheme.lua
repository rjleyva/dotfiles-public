return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      variant = "main", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = true,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
      },

      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },

      palette = {
        -- Override the builtin palette per variant
        -- moon = {
        --     base = '#18191a',
        --     overlay = '#363738',
        -- },
      },

      -- NOTE: Highlight groups are extended (merged) by default. Disable this
      -- per group via `inherit = false`
      highlight_groups = {
        -- Comment = { fg = "foam" },
        -- StatusLine = { fg = "love", bg = "love", blend = 15 },
        -- VertSplit = { fg = "muted", bg = "muted" },
        -- Visual = { fg = "base", bg = "text", inherit = false },
        Visual = { reverse = true, inherit = false },
      },

      before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        if highlight.fg == palette.pine then
          highlight.fg = palette.foam
        end
      end,
    })

    vim.cmd("colorscheme rose-pine-main")
  end,
}

-- morhetz/gruvbox colorscheme
-- return {
--   "morhetz/gruvbox",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     local transparent = true
--
--     vim.o.background = "dark"
--     vim.g.gruvbox_italic = 1
--     vim.g.gruvbox_italicize_comments = 1
--     vim.g.gruvbox_italicize_strings = 1
--     -- vim.g.gruvbox_improved_strings = 1
--     vim.g.gruvbox_italicize_keywords = 1
--     vim.g.gruvbox_bold = 1
--
--     vim.cmd.colorscheme("gruvbox")
--
--     local hl = vim.api.nvim_set_hl
--     if transparent then
--       hl(0, "Normal", { bg = "none" })
--       hl(0, "NormalNC", { bg = "none" })
--       hl(0, "NormalFloat", { bg = "none" })
--       hl(0, "FloatBorder", { bg = "none" })
--       hl(0, "SignColumn", { bg = "none" })
--       hl(0, "VertSplit", { bg = "none" })
--     end
--   end,
-- }

-- craftzdog/solarized-osaka colorscheme
-- return {
--   "craftzdog/solarized-osaka.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {
--     use_background = "dark",
--     border = "rounded",
--     enable_italics = true,
--     style = "dark",
--     transparent = true,
--     terminal_colors = true,
--     styles = {
--       boolean = { bold = true },
--       comments = { bold = true },
--       conditionals = { italic = true },
--       functions = { bold = true },
--       keywords = { bold = true },
--       loops = { italic = true },
--       misc = { italic = true },
--       numbers = { bold = true },
--       operators = { bold = true },
--       properties = { italic = true },
--       string = { bold = false },
--       types = { italic = true },
--       underline = true,
--       undercurl = true,
--       variables = { italic = true },
--     },
--   },
--   config = function(_, opts)
--     require("solarized-osaka").setup(opts)
--     vim.cmd.colorscheme("solarized-osaka")
--     vim.api.nvim_set_hl(0, "Visual", { reverse = true })
--   end,
-- }
