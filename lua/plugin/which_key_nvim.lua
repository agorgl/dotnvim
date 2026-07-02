--
-- plugin.which_key_nvim
--

local M = {}

function M.config()
  local which_key = require("which-key")
  which_key.setup({})
end

return M
