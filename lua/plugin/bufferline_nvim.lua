--
-- plugin.bufferline_nvim
--

local M = {}

function M.config()
  local bufferline = require("bufferline")
  bufferline.setup({
    options = {
      mode = "tabs",
      show_buffer_close_icons = false,
      always_show_bufferline = false,
    },
  })
end

return M
