local modules = {
  "options",
  "plugins",
  "keymaps",
}

for _, m in ipairs(modules) do
  require(m)
end
