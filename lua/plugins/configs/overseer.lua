local M = {}

function M.config()
  local overseer = require("overseer")

  local opts = {
    strategy = {
      "toggleterm",
    },
    task_list = {
      direction = "right",
    },
  }
  overseer.setup(opts)
end

return M
