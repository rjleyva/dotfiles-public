return {
  "saghen/blink.cmp",
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    {
      "saghen/blink.compat",
      optional = true,
      version = (vim.g.lazyvim_blink_main == true) and "*" or "1.*",
    },
  },
  opts = {
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },

    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },
    signature = { enabled = true },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    completion = {
      ghost_text = { enabled = true },
      trigger = { show_on_keyword = true },
      menu = { draw = { treesitter = { "lsp" } } },
    },

    cmdline = {
      keymap = { preset = "inherit" },
      completion = {
        menu = { auto_show = false },
        ghost_text = { enabled = false },
      },
    },
  },

  config = function(_, opts)
    require("blink.cmp").setup(opts)
  end,
}
