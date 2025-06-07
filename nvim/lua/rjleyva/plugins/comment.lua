return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  opts = {
    pre_hook = function(...)
      local ok, ts_context = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      if ok then
        return ts_context.create_pre_hook()(...)
      end
    end,
  },
}
