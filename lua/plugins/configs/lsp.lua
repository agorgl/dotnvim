local M = {}

function M.setup_diagnostic_signs()
  local diagnostic_signs = {
    { name = "DiagnosticSignError", text = "✘✘" },
    { name = "DiagnosticSignWarn", text = "!!" },
    { name = "DiagnosticSignInfo", text = "--" },
    { name = "DiagnosticSignHint", text = "**" },
  }
  for _, sign in ipairs(diagnostic_signs) do
    vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name })
  end
end

function M.setup_diagnostic_config()
  local config = {
    virtual_text = false,
    severity_sort = true,
    float = {
      border = "rounded",
    },
  }
  vim.diagnostic.config(config)
end

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
      lsp_signature.on_attach({
        bind = true,
        hint_enable = false,
        hint_prefix = "",
        handler_opts = {
          border = "rounded",
        },
      }, ev.buf)
    end,
  })

  M.setup_diagnostic_signs()
  M.setup_diagnostic_config()

  local servers = {
    rust_analyzer = {},
    pyright = {},
    tsserver = {},
    gopls = {},
    jdtls = {},
    clojure_lsp = {},
    ccls = {},
  }

  for server, opts in pairs(servers) do
    local config = {
      capabilities = capabilities,
    }
    for k, v in pairs(opts) do
      config[k] = v
    end
    lspconfig[server].setup(config)
  end
end

return M
