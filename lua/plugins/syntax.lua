return {
  -- Syntax analyzer
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter").config()
    end,
  },
  -- Buffer option heuristics
  "tpope/vim-sleuth",
}
