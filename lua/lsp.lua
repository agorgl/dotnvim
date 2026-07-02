--
-- lsp
--

local configs = {
  clangd = {},
  clojure_lsp = {},
  janet_lsp = {},
  jdtls = {},
  rust_analyzer = {},
  gopls = {},
  pyright = {},
  ts_ls = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          preloadFileSize = 10000,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      },
    },
  },
}

for server, config in pairs(configs) do
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
