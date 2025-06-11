return {
  "mfussenegger/nvim-dap",
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    main = "dapui",
    opts = {},
    config = function()
      require("plugins.configs.dap").config()
    end,
  },
}
