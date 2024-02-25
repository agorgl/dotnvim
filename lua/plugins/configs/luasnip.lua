local M = {}

function M.config()
  local luasnip_loaders_vscode = require("luasnip.loaders.from_vscode")
  luasnip_loaders_vscode.lazy_load()
end

return M
