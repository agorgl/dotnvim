local M = {}

function M.setup_lsp_signature(buf)
  local lsp_signature = require("lsp_signature")
  lsp_signature.on_attach({
    bind = true,
    hint_enable = false,
    hint_prefix = "",
    handler_opts = {
      border = "rounded",
    },
  }, buf)
end

function M.setup_lsp_attach()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      -- Enable signature plugin
      M.setup_lsp_signature(ev.buf)
    end,
  })
end

function M.setup_semantic_highlights()
  local hide_semantic_highlights = function()
    vim.api.nvim_set_hl(0, "@lsp.type.function", {})
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
  end

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("LspSemanticHighlightsClear", {}),
    callback = hide_semantic_highlights,
  })

  hide_semantic_highlights()
end

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
    underline = false,
    virtual_text = false,
    severity_sort = true,
    float = {
      border = "rounded",
    },
  }
  vim.diagnostic.config(config)
end

function M.setup_diagnostic_hover()
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
    callback = function()
      vim.diagnostic.open_float(nil, { focus = false })
    end,
  })
end

function M.setup_floating_windows()
  local handlers = {
    ["textDocument/hover"] = vim.lsp.handlers.hover,
    ["textDocument/signatureHelp"] = vim.lsp.handlers.signature_help,
  }
  for handler, fn in pairs(handlers) do
    vim.lsp.handlers[handler] = vim.lsp.with(fn, {
      border = "rounded",
    })
  end
end

function M.setup_language_servers()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
    config = vim.tbl_extend("force", config, opts)
    lspconfig[server].setup(config)
  end
end

function M.config()
  M.setup_lsp_attach()
  M.setup_semantic_highlights()
  M.setup_diagnostic_signs()
  M.setup_diagnostic_config()
  M.setup_diagnostic_hover()
  M.setup_floating_windows()
  M.setup_language_servers()
end

return M
