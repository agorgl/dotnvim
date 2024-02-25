local M = {}

function M.config()
  local telescope = require("telescope")
  telescope.setup()
  telescope.load_extension("fzf")
  telescope.load_extension("yaml_schema")
end

return M
