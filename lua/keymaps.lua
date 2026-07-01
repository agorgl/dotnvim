--
-- keymaps
--

-- movement
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")

-- tabs
vim.keymap.set({ "n", "t" }, "<A-n>", "<Cmd>tabnext<CR>")
vim.keymap.set({ "n", "t" }, "<A-p>", "<Cmd>tabprev<CR>")

-- terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
