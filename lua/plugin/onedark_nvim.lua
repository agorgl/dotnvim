--
-- plugin.onedark_nvim
--

local M = {}

function M.config()
  local onedark = require("onedark")
  onedark.setup({
    style = "darker",
  })
end

return M
