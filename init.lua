local ok, impatient = pcall(require, "impatient")
if ok then
   impatient.enable_profile()
end

local modules = {
  'options',
  'plugins',
  'mappings',
  'colors',
}

for _, m in ipairs(modules) do
  local ok, err = pcall(require, m)
  if not ok then
    error("Error loading " .. m .. "\n\n" .. err)
  end
end
