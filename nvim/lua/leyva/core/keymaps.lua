local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>ch", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap.set("n", "<leader>xv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>xh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>xe", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>xx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>ot", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>ox", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>on", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>op", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>ob", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
