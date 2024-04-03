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

function M.setup_filetype_detection()
  local yaml_ft = function(path, bufnr)
    -- Get content of buffer as string
    local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    if type(content) == "table" then
      content = table.concat(content, "\n")
    end

    -- Check if file is in roles, tasks, or handlers folder
    local path_regex = vim.regex("(tasks\\|roles\\|handlers)/")
    if path_regex and path_regex:match_str(path) then
      return "yaml.ansible"
    end

    -- Check for known ansible playbook text and if found, return yaml.ansible
    local regex = vim.regex("hosts:\\|tasks:")
    if regex and regex:match_str(content) then
      return "yaml.ansible"
    end

    -- Return yaml if nothing else
    return "yaml"
  end

  vim.filetype.add({
    extension = {
      yml = yaml_ft,
      yaml = yaml_ft,
    },
  })
end

local function yamlls_config()
  local schemastore = require("schemastore")
  local yaml_companion = require("yaml-companion")

  local lsp_config = {
    settings = {
      yaml = {
        format = { enable = true },
        validate = true,
        hover = true,
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = schemastore.yaml.schemas({
          select = {
            "kustomization.yaml",
          },
        }),
      },
      redhat = { telemetry = { enabled = false } },
    },
  }

  local companion_config = {
    builtin_matchers = {
      kubernetes = { enabled = true },
    },
    schemas = {
      {
        name = "Argo CD Application",
        uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
      },
      {
        name = "Argo CD ApplicationSet",
        uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/applicationset_v1alpha1.json",
      },
      {
        name = "Argo Workflows Workflow",
        uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/workflow_v1alpha1.json",
      },
      {
        name = "Argo Workflows WorkflowTemplate",
        uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/workflowtemplate_v1alpha1.json",
      },
    },
    lspconfig = lsp_config,
  }

  return yaml_companion.setup(companion_config)
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
    yamlls = yamlls_config(),
    ansiblels = {},
    tailwindcss = {
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              ':class\\s+"([^"]*)"',
              ":[\\w-.#>]+\\.([\\w-]*)",
            },
          },
          includeLanguages = {
            clojure = "html",
          },
        },
      },
    },
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
  M.setup_filetype_detection()
  M.setup_language_servers()
end

return M
