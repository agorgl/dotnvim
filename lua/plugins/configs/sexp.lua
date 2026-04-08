local M = {}

function M.init()
  vim.g["sexp_mappings"] = {
    sexp_put_before = "",
    sexp_put_after = "",
    sexp_replace = "",
    sexp_replace_P = "",
    sexp_replace_op = "",
    sexp_replace_op_P = "",
  }
end

return M
