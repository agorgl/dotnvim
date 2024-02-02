return {
  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("plugins.configs.cmp").config()
    end,
  },
  -- Snippet engine
  "L3MON4D3/LuaSnip",
}
