--
-- plugin.nvim_lspconfig
--

local M = {}

function M.config()
  local configs = {
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
end

return M
