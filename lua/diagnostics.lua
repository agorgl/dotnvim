--
-- diagnostics
--

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "!",
      [vim.diagnostic.severity.INFO] = "»",
      [vim.diagnostic.severity.HINT] = "*",
    },
  },
  severity_sort = true,
  underline = false,
  virtual_text = false,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("diagnostic.hold", { clear = true }),
  callback = function()
    if vim.fn.pumvisible() ~= 0 then
      return
    end

    local blink_cmp = require("blink.cmp")
    if blink_cmp.is_menu_visible() then
      return
    end

    vim.diagnostic.open_float({
      severity_sort = true,
      focusable = false,
    })
  end,
})
