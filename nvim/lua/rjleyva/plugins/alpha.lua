return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "          heehee      /aa \\_",
      "                   __\\-  / )                 .-.",
      "         .-.      (__/    /        haha    _/oo \\",
      "       _/ ..\\       /     \\               ( \\v  /__",
      "      ( \\  u/__    /       \\__             \\/   ___)",
      "       \\    \\__)   \\_.-._._   )  .-.       /     \\",
      "       /     \\             `-`  / ee\\_    /       \\_",
      "    __/       \\               __\\  o/ )   \\_.-.__   )",
      "   (   _._.-._/     hoho     (___   \\/           '-'",
      "jgs '-'                        /     \\",
      "                             _/       \\    teehee",
      "                            (   __.-._/",
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
