return {
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
  },
}
