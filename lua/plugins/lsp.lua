return {
  -- LSP configs
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/schemastore.nvim",
      "someone-stole-my-name/yaml-companion.nvim",
    },
    config = function()
      require("plugins.configs.lsp").config()
    end,
  },
  -- LSP servers
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  -- LSP servers integration
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {},
  },
  -- LSP signatures
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
