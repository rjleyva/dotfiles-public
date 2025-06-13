local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>ch", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>/t", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>/x", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>/n", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>/p", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>/b", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

keymap.set("n", "<leader>cc", function()
  local commentstring = vim.bo.commentstring:match("^(.*)%%s")
  local line = vim.api.nvim_get_current_line()
  if line:match("^%s*" .. vim.pesc(commentstring)) then
    line = line:gsub("^(%s*)" .. vim.pesc(commentstring) .. "%s*", "%1")
  else
    line = commentstring .. " " .. line
  end
  vim.api.nvim_set_current_line(line)
end, { desc = "Toggle line comment" })
