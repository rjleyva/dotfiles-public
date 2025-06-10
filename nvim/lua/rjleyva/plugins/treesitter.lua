return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  build = ":TSUpdate",
  version = false,
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = { "BufReadPre", "BufNewFile" },
      lazy = true,
      config = function()
        require("treesitter-context").setup({
          enabled = true,
          max_lines = 3,
          trim_scope = "outer",
          mode = "cursor",
        })
      end,
    },
    {
      "windwp/nvim-ts-autotag",
      event = { "BufReadPre", "BufNewFile" },
      lazy = true,
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    },
  },
  keys = {
    { "<C-space>", desc = "Increment Selection" },
    { "<BS>", desc = "Decrement Selection", mode = "x" },
    { "]f", desc = "Next Function Start" },
    { "]F", desc = "Next Function End" },
    { "]a", desc = "Next Parameter Start" },
    { "]A", desc = "Next Parameter End" },
    { "[f", desc = "Prev Function Start" },
    { "[F", desc = "Prev Function End" },
    { "[a", desc = "Prev Parameter Start" },
    { "[A", desc = "Prev Parameter End" },
  },
  opts = {
    ensure_installed = {
      "bash",
      "css",
      "gitignore",
      "graphql",
      "html",
      "http",
      "javascript",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        node_decremental = "<BS>",
        scope_incremental = false,
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
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

    vim.filetype.add({
      extension = { mdx = "mdx" },
    })
    vim.treesitter.language.register("markdown", "mdx")
  end,
}
