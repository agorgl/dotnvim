return {
  -- LSP configs
  {
    "neovim/nvim-lspconfig",
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
}
