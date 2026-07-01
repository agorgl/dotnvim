--
-- plugin.mini_align
--

local M = {}

function M.config()
  local mini_align = require("mini.align")
  mini_align.setup()
end

return M
