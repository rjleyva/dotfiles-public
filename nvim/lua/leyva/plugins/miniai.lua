return {
  "echasnovski/mini.ai",
  version = "*",
  event = "VeryLazy",
  dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
  opts = function()
    local ai = require("mini.ai")

    vim.keymap.set(
      "o",
      "aF",
      "<cmd>lua require('mini.ai').select_textobject('f', 'a')<CR>",
      { desc = "Around function" }
    )

    return {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
        b = { "%b()", "%b[]", "%b{}" },
        m = { "^#+%s().-()%s*#", "^#+%s().-()%s*$" },
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        d = { "%f[%d]%d+" },
        e = {
          { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
          "^().*()$",
        },
        u = ai.gen_spec.function_call(),
        U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
        x = ai.gen_spec.treesitter({
          a = { "@tag.outer" },
          i = { "@tag.inner" },
        }),
      },
    }
  end,
  config = function(_, opts)
    require("mini.ai").setup(opts)
  end,
}
