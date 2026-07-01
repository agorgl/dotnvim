--
-- plugin.nvim_autopairs
--

local M = {}

function M.config()
  local nvim_autopairs = require("nvim-autopairs")
  nvim_autopairs.setup({})
end

return M
