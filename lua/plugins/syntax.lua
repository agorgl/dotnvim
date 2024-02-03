return {
  -- Syntax analyzer
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = "all",
      highlight = {
        enable = true,
      },
    },
  },
  -- Buffer option heuristics
  "tpope/vim-sleuth",
}
