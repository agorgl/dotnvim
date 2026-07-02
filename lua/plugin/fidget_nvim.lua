--
-- plugin.fidget_nvim
--

local M = {}

function M.config()
  local fidget = require("fidget")
  fidget.setup({})
end

return M
