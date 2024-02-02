return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = {},
  },
  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        always_show_bufferline = false,
      },
    },
  },
  -- Keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- Notifications
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
}
