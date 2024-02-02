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

-- LSP
map("n", "<space>e", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<space>q", vim.diagnostic.setloclist)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gt", vim.lsp.buf.type_definition, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

-- Conform
map("n", "<leader>f", function()
  local conform = require("conform")
  conform.format({ async = true, lsp_fallback = true })
end)
