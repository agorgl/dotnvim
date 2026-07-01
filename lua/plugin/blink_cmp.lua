--
-- plugin.blink_cmp
--

local M = {}

function M.build(_)
  local blink_cmp = require("blink.cmp")
  blink_cmp.build():pwait()
end

return M
