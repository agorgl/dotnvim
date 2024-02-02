local M = {}

function M.config()
  local telescope = require("telescope")
  telescope.setup()
  telescope.load_extension("fzf")
end

return M
