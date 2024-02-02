local map = vim.keymap.set

-- Tabs
map({ "n", "t" }, "<M-n>", "<cmd>tabnext<CR>")
map({ "n", "t" }, "<M-p>", "<cmd>tabprev<CR>")
