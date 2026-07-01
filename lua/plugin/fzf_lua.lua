--
-- plugin.fzf_lua
--

local M = {}

function M.config()
  local fzf_lua = require("fzf-lua")
  fzf_lua.setup({
    winopts = {
      backdrop = false,
    },
    fzf_colors = true,
  })
end

return M
