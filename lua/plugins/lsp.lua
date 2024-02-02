return {
  -- LSP configs
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lsp").config()
    end,
  },
}
