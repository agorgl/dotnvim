--
-- plugin.nvim_treesitter
--

local M = {}

function M.build(kind)
  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
      if kind == "install" then
        vim.cmd("TSInstall all")
      else
        vim.cmd("TSUpdate")
      end
    end,
  })
end

return M
