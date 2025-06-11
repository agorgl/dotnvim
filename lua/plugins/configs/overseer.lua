local M = {}

local project_types = {
  {
    type = "just",
    patterns = { "justfile" },
    tasks = {
      run = { "just", "run" },
    },
  },
  {
    type = "c",
    patterns = { "meson.build" },
    tasks = {
      run = { "meson", "compile", "-C", "build" },
    },
  },
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

local function find_project_type(path)
  local any_pattern_exists = function(patterns)
    local found = vim.fs.find(function(name)
      local matches = vim.tbl_filter(function(pat)
        local candidates = vim.split(vim.fn.glob(pat), "\n")
        return vim.tbl_contains(candidates, name)
      end, patterns)
      return not vim.tbl_isempty(matches)
    end, { upward = true, path = path, stop = vim.loop.os_homedir() })
    return not vim.tbl_isempty(found)
  end

  for _, t in ipairs(project_types) do
    local match = any_pattern_exists(t.patterns)
    local skip = any_pattern_exists(t.skip_patterns or {})
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
      overseer.run_template({ tags = { overseer.TAG.RUN } })
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
