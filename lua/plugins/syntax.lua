return {
  -- Syntax analyzer
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
  },
  -- Buffer option heuristics
  "tpope/vim-sleuth",
}
