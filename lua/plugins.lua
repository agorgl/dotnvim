--
-- plugins
--

local gh = function(x)
  return "https://github.com/" .. x
end

local plugin_module = function(name)
  return string.format("plugin.%s", string.gsub(name, "[.-]", "_"))
end

local specs = {
  -- navigation
  { src = gh("ibhagwan/fzf-lua") },
  { src = gh("stevearc/oil.nvim") },

  -- syntax
  { src = gh("nvim-treesitter/nvim-treesitter") },
  { src = gh("tpope/vim-sleuth") },

  -- editing
  { src = gh("kylechui/nvim-surround") },
  { src = gh("windwp/nvim-autopairs") },
  { src = gh("windwp/nvim-ts-autotag") },
  { src = gh("stevearc/conform.nvim") },
  { src = gh("nvim-mini/mini.align") },

  -- completion
  { src = gh("saghen/blink.cmp") },
  { src = gh("saghen/blink.lib") },
  { src = gh("rafamadriz/friendly-snippets") },

  -- lsp
  { src = gh("neovim/nvim-lspconfig") },

  -- git
  { src = gh("tpope/vim-fugitive") },
  { src = gh("lewis6991/gitsigns.nvim") },

  -- runners
  { src = gh("akinsho/toggleterm.nvim") },
  { src = gh("stevearc/overseer.nvim") },

  -- lisp
  { src = gh("eraserhd/parinfer-rust") },
  { src = gh("guns/vim-sexp") },
  { src = gh("tpope/vim-sexp-mappings-for-regular-people") },
  { src = gh("olical/conjure") },

  -- ui
  { src = gh("nvim-lualine/lualine.nvim") },
  { src = gh("akinsho/bufferline.nvim") },
}

local events = {}
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("pack.changed", { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    events[name] = kind
  end,
})

vim.pack.add(specs, { confirm = false })

---@diagnostic disable: redefined-local
for _, plugin in ipairs(vim.pack.get()) do
  local plugin_name = plugin.spec.name
  local ok, module = pcall(require, plugin_module(plugin_name))
  if ok then
    local event_kind = events[plugin_name]
    if event_kind ~= nil then
      if module.build ~= nil then
        local ok, result = xpcall(module.build, debug.traceback, event_kind)
        if not ok then
          local msg = string.format("error: plugins: could not build plugin '%s': %s", plugin_name, result)
          vim.notify(msg, vim.log.levels.ERROR)
        end
      end
    end

    if module.config ~= nil then
      local ok, result = xpcall(module.config, debug.traceback)
      if not ok then
        local msg = string.format("error: plugins: could not configure plugin '%s': %s", plugin_name, result)
        vim.notify(msg, vim.log.levels.ERROR)
      end
    end
  end
end
---@diagnostic enable: redefined-local
