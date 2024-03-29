return {
  -- Terminal manager
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      shade_terminals = false,
      float_opts = {
        border = "rounded",
      },
    },
  },
  -- Task runner
  {
    "stevearc/overseer.nvim",
    config = function()
      require("plugins.configs.overseer").config()
    end,
  },
}
