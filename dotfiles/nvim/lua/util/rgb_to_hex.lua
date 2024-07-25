return function(rgb)
  if rgb == nil then
    return nil
  end

  local r = string.format("%02x", (rgb / 65536) % 256)
  local g = string.format("%02x", (rgb / 256) % 256)
  local b = string.format("%02x", rgb % 256)

  return "#"..r..g..b
end
