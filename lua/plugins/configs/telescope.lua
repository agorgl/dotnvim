local M = {}

function M.config()
  local telescope = require("telescope")
  telescope.load_extension("fzf")
end

return M
