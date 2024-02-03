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
  -- Interactive evaluation
  {
    "Olical/conjure",
    ft = { "clojure", "scheme" },
    config = function()
      require("plugins.configs.conjure").config()
    end,
  },
}
