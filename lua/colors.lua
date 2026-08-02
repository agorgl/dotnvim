--
-- colors
--

-- embedded background
if vim.tbl_contains(vim.v.argv, "--embed") then
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("colors.embedded.changed", { clear = true }),
    callback = function(_)
      local transparent = require("transparent")
      transparent.toggle(true)
    end,
  })
end

-- colorscheme
vim.cmd("colorscheme onedark")
