return {
  "mfussenegger/nvim-lint",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function(_, _)
        local ft = vim.bo.filetype
        if lint.linters_by_ft[ft] ~= nil then
          lint.try_lint()
        end
      end,
    })

    vim.keymap.set("n", "<leader>ll", function(_)
      local ft = vim.bo.filetype
      if lint.linters_by_ft[ft] ~= nil then
        lint.try_lint()
      else
        vim.notify("No linter configured for this filetype: " .. ft, vim.log.levels.WARN)
      end
    end, { desc = "Trigger linting for current file" })

    vim.keymap.set("n", "<leader>le", function()
      vim.diagnostic.setqflist()
    end, { desc = "Send lint diagnostics to quickfix list" })
  end,
}
