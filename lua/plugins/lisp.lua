return {
  -- Smart lisp editing
  {
    "eraserhd/parinfer-rust",
    build = "cargo build --release",
    ft = { "clojure", "scheme" },
  },
}
