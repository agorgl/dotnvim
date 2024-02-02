return {
  -- Smart lisp editing
  {
    "eraserhd/parinfer-rust",
    build = "cargo build --release",
    ft = { "clojure", "scheme" },
  },
  -- Sexp editing
  {
    "guns/vim-sexp",
    dependencies = {
      "vim-sexp-mappings-for-regular-people",
    },
    ft = { "clojure", "scheme" },
  },
}
