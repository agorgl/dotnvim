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
      run = { "clj", "-M:dev:test:repl/headless" },
    },
  },
  {
    type = "clojurescript",
    patterns = { "shadow-cljs.edn" },
    tasks = {
      run = { "clj", "-M:dev:test:repl/headless:cljs" },
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
    task_list = {
      direction = "right",
    },
  }
  overseer.setup(opts)

  local toggle_state = {
    created = false,
    task = nil,
    buffer = -1,
    window = -1,
  }

  vim.api.nvim_create_user_command("OverseerRunToggle", function()
    if vim.api.nvim_win_is_valid(toggle_state.window) then
      vim.api.nvim_win_hide(toggle_state.window)
      toggle_state.window = -1
    else
      local setup_window = function(window)
        vim.api.nvim_set_option_value("number", false, { scope = "local", win = window })
        vim.api.nvim_set_option_value("relativenumber", false, { scope = "local", win = window })
        vim.api.nvim_set_option_value("signcolumn", "no", { scope = "local", win = window })
      end

      local maybe_insert = function(task)
        if task and task:is_running() then
          vim.cmd("startinsert")
        end
      end

      if not toggle_state.created then
        toggle_state.created = true

        local temp_buf = vim.api.nvim_create_buf(false, true)
        toggle_state.buffer = temp_buf

        overseer.run_task({ tags = { overseer.TAG.RUN } }, function(task)
          if task:has_component("on_complete_dispose") then
            task:remove_component("on_complete_dispose")
          end

          toggle_state.task = task
          toggle_state.buffer = task:get_bufnr()

          if toggle_state.window ~= -1 then
            vim.api.nvim_win_set_buf(toggle_state.window, toggle_state.buffer)
            setup_window(toggle_state.window)
            maybe_insert(toggle_state.task)
          end
        end)
      else
        local task = toggle_state.task
        if task and task:is_complete() then
          task:restart()
          toggle_state.buffer = task:get_bufnr()
        end
      end

      toggle_state.window = vim.api.nvim_open_win(toggle_state.buffer, true, {
        height = 12,
        split = "below",
        win = -1,
      })
      setup_window(toggle_state.window)
      maybe_insert(toggle_state.task)
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
      generator = function(search)
        local pt = find_project_type(search.dir)
        if pt == nil or t.type ~= pt.type then
          return nil
        end
        return task_templates
      end,
    })
  end

  local overseer_setup_group = vim.api.nvim_create_augroup("overseer_setup", { clear = true })
  vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
    group = overseer_setup_group,
    callback = function()
      local cwd = vim.fn.getcwd()
      overseer.preload_task_cache({ dir = cwd })
    end,
  })
end

return M
