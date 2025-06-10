return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    { "rafamadriz/friendly-snippets", event = "InsertEnter" },
    {
      "saghen/blink.compat",
      optional = true,
      version = vim.g.lazyvim_blink_main and "*" or "1.*",
    },
  },
  opts = function()
    return {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      signature = { enabled = true },
      fuzzy = { implementation = "prefer_rust_with_warning" },

      completion = {
        ghost_text = { enabled = true },
        trigger = {
          show_on_keyword = true,
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
      },

      cmdline = {
        keymap = { preset = "inherit" },
        completion = {
          menu = { auto_show = false },
          ghost_text = { enabled = false },
        },
      },
    }
  end,
  config = function(_, opts)
    vim.schedule(function()
      require("blink.cmp").setup(opts)
    end)
  end,
}
