--
-- init
--

local modules = {
  "options",
  "plugins",
  "keymaps",
  "diagnostics",
  "colors",
}

for _, m in ipairs(modules) do
  local ok, result = xpcall(require, debug.traceback, m)
  if not ok then
    local msg = string.format("error: init: could not require '%s' module: %s", m, result)
    vim.notify(msg, vim.log.levels.ERROR)
  end
end
