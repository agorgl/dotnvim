local modules = {
  "options",
  "plugins",
}

for _, m in ipairs(modules) do
  require(m)
end
