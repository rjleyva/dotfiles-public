local keys = vim.keymap

-- Exit Insert Mode
keys.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Inspired by Josean Martinez's Neovim config including Neovim structure
-- Navigation & Editing
keys.set("n", "x", '"_x', { desc = "Delete char without copying to register" })
keys.set("n", "<leader>+", "<C-a>", { desc = "Increment number under cursor" })
keys.set("n", "<leader>-", "<C-x>", { desc = "Decrement number under cursor" })

-- Window Management
keys.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
keys.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
keys.set("n", "<leader>we", "<C-w>=", { desc = "Equalize split sizes" })
keys.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tab Management
keys.set("n", "<leader>/t", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keys.set("n", "<leader>/x", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keys.set("n", "<leader>/n", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keys.set("n", "<leader>/p", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keys.set("n", "<leader>/b", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Inspired by folke/LazyVim
-- I use it as a reference to improve and build my own config with folke/lazy.nvim plugin manager.
keys.set("n", "<leader>ch", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", {
  desc = "Clear highlights, update diff, and redraw screen",
})

-- Launch lazy.nvim
keys.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Open Lazy.nvim plugin manager" })

-- Exit
keys.set("n", "<leader>X", "<cmd>qa<cr>", { desc = "Quit all windows and exit" })

-- New file
-- NOTE: This opens a new unnamed buffer.
--       to save it, run `:w filename.ext` (e.g., :w notes.txt).
keys.set("n", "<leader>N", "<cmd>enew<cr>", { desc = "New File" })

-- Inspection tools
-- NOTE: Useful for inspecting syntax nodes and highlighting info under cursor.
-- Show highlight groups and extmarks at the cursor position
keys.set("n", "<leader>i", vim.show_pos, { desc = "Inspect highlight groups under cursor" })

-- Open Treesitter syntax tree inspector and enter insert mode
keys.set("n", "<leader>I", function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input("I")
end, { desc = "Open Treesitter Inspector + Insert Mode" })

-- Commenting
keys.set("n", "<leader>co", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Insert line below with comment" })
keys.set("n", "<leader>cO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Insert line above with comment" })

keys.set("n", "<leader>cc", function()
  local commentstring = vim.bo.commentstring:match("^(.*)%%s")
  local line = vim.api.nvim_get_current_line()
  if line:match("^%s*" .. vim.pesc(commentstring)) then
    line = line:gsub("^(%s*)" .. vim.pesc(commentstring) .. "%s*", "%1")
  else
    line = commentstring .. " " .. line
  end
  vim.api.nvim_set_current_line(line)
end, { desc = "Toggle line comment (manual implementation)" })
