local map = vim.keymap.set

-- Movement
map("n", "j", "gj")
map("n", "k", "gk")

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

-- LSP
map("n", "<space>e", vim.diagnostic.open_float)
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
map("n", "<space>q", vim.diagnostic.setloclist)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gt", vim.lsp.buf.type_definition, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gr", telescope_builtin.lsp_references, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ci", vim.lsp.buf.incoming_calls, opts)
    map("n", "<leader>co", vim.lsp.buf.outgoing_calls, opts)
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

-- Conform
map("n", "<leader>f", function()
  local conform = require("conform")
  conform.format({ async = true, lsp_fallback = true })
end)

-- Toggleterm
map({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm<CR>")

-- Overseer
map({ "n", "t" }, "<leader>tl", "<cmd>OverseerToggle<CR>")
map({ "n", "t" }, "<leader>ta", "<cmd>OverseerQuickAction<CR>")
map({ "n", "t" }, "<leader>td", "<cmd>OverseerQuickAction dispose<CR>")
map({ "n", "t" }, "<leader>tr", "<cmd>OverseerRun<CR>")
map({ "n", "t" }, "<leader>rr", "<cmd>OverseerRunToggle<CR>")

-- Scripts
map({ "v", "x" }, "<leader>h", ":'<,'>!bb " .. vim.fn.stdpath("config") .. "/scripts/html2hiccup.clj<CR>")
