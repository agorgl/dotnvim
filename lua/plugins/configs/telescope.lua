local M = {}

local is_inside_work_tree = {}

function M.config()
  local telescope = require("telescope")
  telescope.setup({
    pickers = {
      find_files = {
        hidden = true,
      },
      git_files = {
        show_untracked = true,
      },
      live_grep = {
        hidden = true,
        additional_args = { "--hidden", "--glob", "!**/.git/*" },
      },
    },
  })
  telescope.load_extension("fzf")
  telescope.load_extension("yaml_schema")
end

function M.smart_find(opts)
  opts = opts or {}

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  local telescope_builtin = require("telescope.builtin")
  if is_inside_work_tree[cwd] then
    telescope_builtin.git_files(opts)
  else
    telescope_builtin.find_files(opts)
  end
end

return M
