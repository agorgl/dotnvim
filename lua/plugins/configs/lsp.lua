local M = {}

function M.config()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      -- Enable signature plugin
      local lsp_signature = require("lsp_signature")
      lsp_signature.on_attach({}, ev.buf)
    end,
  })

  local servers = {}

  for server, opts in pairs(servers) do
    local config = {
      capabilities = capabilities,
    }
    for k, v in pairs(opts) do
      config[k] = v
    end
    lspconfig[lsp].setup(config)
  end
end

return M
