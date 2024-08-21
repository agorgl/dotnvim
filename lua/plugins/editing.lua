return {
  -- Surround editing
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.configs.autopairs").config()
    end,
  },
  -- Autotags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
  -- Formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo", "FormatDisable", "FormatEnable" },
    config = function()
      require("plugins.configs.conform").config()
    end,
  },
}
