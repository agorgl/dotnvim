--
-- plugin.toggleterm_nvim
--

local M = {}

function M.config()
  local toggleterm = require("toggleterm")
  toggleterm.setup({
    shade_terminals = false,
  })
end

return M
