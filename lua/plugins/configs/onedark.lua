local M = {}

function M.config(opts)
  local onedark = require("onedark")
  onedark.setup(opts)
  onedark.load()
end

return M
