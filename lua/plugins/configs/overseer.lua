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

  vim.api.nvim_create_user_command("OverseerRunToggle", function()
    local tasks = overseer.list_tasks()
    if not vim.tbl_isempty(tasks) then
      local task = tasks[1]
      if task.strategy.name == "toggleterm" then
        local term = task.strategy.term
        term:toggle()
      end
    else
      --overseer.run_template({ tags = { overseer.TAG.BUILD } })
      overseer.run_template({ tags = { "RUN" } })
    end
  end, {})
end

return M
