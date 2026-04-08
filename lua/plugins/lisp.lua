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
      "tpope/vim-sexp-mappings-for-regular-people",
    },
    ft = { "clojure", "scheme" },
    init = function()
      require("plugins.configs.sexp").init()
    end,
  },
  -- Interactive evaluation
  {
    "Olical/conjure",
    branch = "main",
    ft = { "clojure", "scheme" },
    config = function()
      require("plugins.configs.conjure").config()
    end,
  },
}
