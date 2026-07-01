--
-- plugin.nvim_ts_autotag
--

local M = {}

function M.config()
  local nvim_ts_autotag = require("nvim-ts-autotag")
  nvim_ts_autotag.setup({})
end

return M
