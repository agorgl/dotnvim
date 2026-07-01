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

-- fzf-lua
vim.keymap.set("n", "<leader>fa", "<Cmd>FzfLua builtin<CR>")
vim.keymap.set("n", "<leader>ff", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<leader>fw", "<Cmd>FzfLua live_grep<CR>")
vim.keymap.set("v", "<leader>fs", "<Cmd>FzfLua grep_visual<CR>")

-- oil.nvim
vim.keymap.set("n", "-", "<Cmd>Oil<CR>")

-- toggleterm.nvim
vim.keymap.set({ "n", "t" }, "<leader>tt", "<Cmd>ToggleTerm<CR>")
