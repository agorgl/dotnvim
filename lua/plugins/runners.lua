return {
  -- Terminal manager
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {},
  },
  -- Task runner
  {
    "stevearc/overseer.nvim",
    config = function()
      require("plugins.configs.overseer").config()
    end,
  },
}
