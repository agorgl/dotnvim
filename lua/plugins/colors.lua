return {
  -- Colorscheme
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "darker",
      highlights = {
        NvimTreeNormal = { bg = "$bg0" },
        NvimTreeEndOfBuffer = { bg = "$bg0" },
      },
    },
    config = function(_, opts)
      require("plugins.configs.onedark").config(opts)
    end,
  },
  -- Background color
  {
    "agorgl/nvim-bg",
    opts = {},
  },
}
