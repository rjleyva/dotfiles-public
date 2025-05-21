return {
  "b0o/incline.nvim",
  event = "BufReadPre",
  priority = 1200,
  opts = {
    window = {
      padding = 0,
      margin = { horizontal = 0 },
    },
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      local modified = vim.bo[props.buf].modified
      local buffer = {
        " ",
        { filename, gui = modified and "bold,italic" or "italic" },
        " ",
        guifg = "#000000",
        guibg = "#98971a",
      }
      return buffer
    end,
  },
}
