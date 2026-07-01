--
-- plugin.gitsigns_nvim
--

local M = {}

function M.config()
  local gitsigns = require("gitsigns")
  gitsigns.setup({
    -- stylua: ignore start
    signs = {
      add          = { text = '+' },
      change       = { text = '~' },
      delete       = { text = '-' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '+' },
    },
    -- stylua: ignore end
    signs_staged_enable = false,
  })
end

return M
