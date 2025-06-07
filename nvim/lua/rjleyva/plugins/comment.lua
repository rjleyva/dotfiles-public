return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      lazy = true,
    },
  },
  opts = {
    pre_hook = function(...)
      local ok, ts_context = pcall(function()
        if not package.loaded["ts_context_commentstring"] then
          require("lazy").load({ plugins = { "nvim-ts-context-commentstring" } })
        end
        return require("ts_context_commentstring.integrations.comment_nvim")
      end)

      if ok then
        return ts_context.create_pre_hook()(...)
      end
    end,
  },
}
