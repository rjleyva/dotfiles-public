return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "┏━━━┓━┏┓┓━━━━━━┓┓━━┏┓┓━━┏┓━━━┓",
      "┃┏━┓┃━┃┃┃━━━┏━━┛┗┓┏┛┃┗┓┏┛┃┏━┓┃",
      "┃┗━┛┃━┃┃┃━━━┗━━┓┓┗┛┏┛┓┃┃┏┛┃━┃┃",
      "┃┏┓┏┛┓┃┃┃━┏┓┏━━┛┗┓┏┛━┃┗┛┃━┗━┛┃",
      "┃┃┃┗┓┗┛┃┗━┛┃┗━━┓━┃┃━━┗┓┏┛━┏━┓┃",
      "┗┛┗━┛━━┛━━━┛━━━┛━┗┛━━━┗┛━━┛━┗┛",
      "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
      "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
      dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>Neotree toggle<CR>"),
      dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>FzfLua files<CR>"),
      dashboard.button("SPC fs", "  > Find Word", "<cmd>FzfLua live_grep<CR>"),
      dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
    }

    alpha.setup(dashboard.opts)
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
