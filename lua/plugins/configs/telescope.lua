local M = {}

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

return M
