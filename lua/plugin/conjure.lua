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
  vim.g["conjure#filetype#janet"] = "conjure.client.janet.stdio"
end

return M
