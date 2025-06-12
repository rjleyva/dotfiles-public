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

  opts = {
    ensure_installed = {
      "astro",
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
      "svelte",
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

  keys = {
    {
      "<leader>ci",
      function()
        if vim.fn.mode() == "n" then
          vim.cmd("normal! v")
        end
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-space>", true, false, true), "")
      end,
      desc = "Increment Selection",
      mode = { "n", "v" },
    },
    {
      "<leader>cd",
      function()
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<BS>", true, false, true), "")
      end,
      desc = "Decrement Selection",
      mode = { "v" },
    },
    { "]f", desc = "Next Function Start" },
    { "]F", desc = "Next Function End" },
    { "]a", desc = "Next Parameter Start" },
    { "]A", desc = "Next Parameter End" },
    { "[f", desc = "Prev Function Start" },
    { "[F", desc = "Prev Function End" },
    { "[a", desc = "Prev Parameter Start" },
    { "[A", desc = "Prev Parameter End" },
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    vim.filetype.add({
      extension = {
        mdx = "mdx",
      },
    })

    vim.treesitter.language.register("markdown", "mdx")
  end,
}
