return {
  "saghen/blink.cmp",
  version = "1.*",
  enabled = true,
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "saghen/blink.compat",
      optional = true,
      version = vim.g.lazyvim_blink_main and "*" or "1.*",
    },
  },
  opts = {
    keymap = {
      preset = "default",
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    signature = {
      enabled = true,
    },
    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },
    cmdline = {
      keymap = { preset = "inherit" },
      completion = {
        menu = {
          auto_show = false,
        },
        ghost_text = {
          enabled = false,
        },
      },
    },
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)
  end,
}
