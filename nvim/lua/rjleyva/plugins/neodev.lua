return {
  "folke/neodev.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("neodev").setup({
      library = {
        enabled = true,
        runtime = true,
        types = true,
        plugins = false,
      },
      setup_jsonls = true,
      diagnostics = { enable = true },
    })
  end,
}
