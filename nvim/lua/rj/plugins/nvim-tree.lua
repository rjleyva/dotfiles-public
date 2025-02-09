return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    local nvim_tree = require("nvim-tree")

    -- Configure NvimTree setup
    nvim_tree.setup({
      actions = {
        open_file = {
          quit_on_open = true,  -- Close the tree when opening a file
        },
      },
      sort = {
        sorter = "case_sensitive",  -- Sort files in a case-sensitive manner
      },
      view = {
        width = 30,  -- Set width of the tree window
        relativenumber = true,  -- Display relative line numbers
      },
      renderer = {
        group_empty = false,  -- Don't group empty directories together
      },
      filters = {
        dotfiles = false,  -- Show dotfiles in the tree
      },
      log = {
        enable = true,  -- Enable logging for debugging
        truncate = true,  -- Truncate long log messages
        types = {
          diagnostics = true,  -- Log diagnostics info
          git = true,  -- Log git info
          profile = true,  -- Log profiling info
          watcher = true,  -- Log watcher events
        },
      },
    })

    -- Key mappings for interacting with the file explorer
    local keymap = vim.keymap

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

    -- Automatically open tree if no arguments are passed
    if vim.fn.argc(-1) == 0 then
      vim.cmd("NvimTreeFocus")
    end
  end,
}
