local M = {}

function M.config()
  local nvimtree = require("nvim-tree")

  local folder_closed, folder_open = "", ""
  local opts = {
    view = {
      signcolumn = "no",
    },
    renderer = {
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = false,
          git = false,
        },
        glyphs = {
          default = " ",
          symlink = " ",
          folder = {
            arrow_closed = folder_closed,
            arrow_open = folder_open,
            default = folder_closed,
            open = folder_open,
            empty = folder_closed,
            empty_open = folder_open,
            symlink = folder_closed,
            symlink_open = folder_open,
          },
        },
      },
    },
  }
  nvimtree.setup(opts)
end

return M
