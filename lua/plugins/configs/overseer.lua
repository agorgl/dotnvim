local M = {}

local project_types = {
  {
    type = "clojure",
    patterns = { "deps.edn" },
    skip_patterns = { "shadow-cljs.edn" },
    tasks = {
      run = { "clj", "-M:dev:repl/headless" },
    },
  },
  {
    type = "clojurescript",
    patterns = { "shadow-cljs.edn" },
    tasks = {
      run = { "npm", "run", "watch" },
    },
  },
}

local function find_project_type(root)
  local files = require("overseer.files")

  for _, t in ipairs(project_types) do
    local relpaths = function(dir, paths)
      return vim.tbl_map(function(p)
        return files.join(dir, p)
      end, paths)
    end
    local patterns = relpaths(root, t.patterns)
    local skip_patterns = relpaths(root, t.skip_patterns or {})

    local match = files.any_exists(unpack(patterns))
    local skip = files.any_exists(unpack(skip_patterns))
    if match and not skip then
      return t
    end
  end

  return nil
end

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

  for _, t in ipairs(project_types) do
    local task_templates = {}
    for task, cmd in pairs(t.tasks) do
      local template = {
        name = t.type .. " " .. task,
        builder = function(_)
          return {
            cmd = cmd,
            components = { "default" },
          }
        end,
        tags = { task:upper() },
      }
      table.insert(task_templates, template)
    end

    overseer.register_template({
      name = t.type,
      generator = function(_, cb)
        cb(task_templates)
      end,
      condition = {
        callback = function(search)
          local pt = find_project_type(search.dir)
          return pt ~= nil and t.type == pt.type
        end,
      },
    })
  end
end

return M
