return {
  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "+" },
      },
      signs_staged_enable = false,
    },
  },
  -- Git wrapper
  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },
}
