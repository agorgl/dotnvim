return {
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = function(plugin)
      require("lazy").load({ plugins = { plugin.name } })
      vim.fn["mkdp#util#install"]()
    end,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
  },
}
