return {
  "nvim-treesitter/nvim-treesitter",
  version = "*",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "windwp/nvim-ts-autotag",
  },
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<C-space>", desc = "Increment Selection" },
    { "<BS>", desc = "Decrement Selection", mode = "x" },
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "jsonc",
      "lua",
      "astro",
      "svelte",
      "vim",
      "vimdoc",
      "markdown",
      "markdown_inline",
      "bash",
      "toml",
      "yaml",
      "gitignore",
      "go",
      "http",
      "graphql",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]a"] = "@parameter.inner",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]A"] = "@parameter.inner",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[a"] = "@parameter.inner",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[A"] = "@parameter.inner",
        },
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    require("nvim-ts-autotag").setup()
    require("treesitter-context").setup({
      enabled = true,
      max_lines = 3,
      trim_scope = "outer",
      mode = "cursor",
    })
  end,
}
