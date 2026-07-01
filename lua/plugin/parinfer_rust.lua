--
-- plugin.parinfer_rust
--

local M = {}

function M.build(_)
  local plugin = vim.pack.get({ "parinfer-rust" })[1]
  vim.system({ "cargo", "build", "--release" }, { cwd = plugin.path }):wait()
end

return M
