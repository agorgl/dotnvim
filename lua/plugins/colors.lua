return {
  -- Colorscheme
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("plugins.configs.onedark").config()
    end,
  },
  -- Background color
  {
    "agorgl/nvim-bg",
    opts = {},
  },
}
