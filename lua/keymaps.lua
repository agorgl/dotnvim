local map = vim.keymap.set

-- Tabs
map({ "n", "t" }, "<M-n>", "<cmd>tabnext<CR>")
map({ "n", "t" }, "<M-p>", "<cmd>tabprev<CR>")

-- Telescope
local telescope_builtin = require("telescope.builtin")
map("n", "<leader>ff", telescope_builtin.find_files)
map("n", "<leader>fw", telescope_builtin.live_grep)

-- Nvimtree
map("n", "<F2>", "<cmd>NvimTreeToggle<CR>")

-- Fugitive
map("n", "<leader>gg", "<cmd>tab Git<CR>")
