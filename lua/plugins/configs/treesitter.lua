local M = {}

function M.config()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
      local ft = args.match
      local buf = args.buf
      local lang = vim.treesitter.language.get_lang(ft)

      local treesitter = require("nvim-treesitter")
      local installed = treesitter.get_installed()

      if vim.list_contains(installed, lang) then
        vim.treesitter.start(buf)
      end
    end,
  })
end

return M
