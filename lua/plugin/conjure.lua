--
-- plugin.conjure
--

local M = {}

function M.config()
  vim.g["conjure#filetypes"] = {
    "clojure",
    "fennel",
    "janet",
    "racket",
    "scheme",
    "lisp",
  }
end

return M
