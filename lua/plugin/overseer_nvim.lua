--
-- plugin.overseer_nvim
--

local M = {}

function M.config()
  local overseer = require("overseer")
  overseer.setup()
end

return M
