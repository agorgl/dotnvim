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

function M.config()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("nvim-treesitter.config", { clear = true }),
    pattern = "*",
    callback = function(_)
      local ok, _ = pcall(vim.treesitter.start)
      if ok then
        -- stylua: ignore
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end

return M
