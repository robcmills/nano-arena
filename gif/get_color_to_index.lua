--- If palette is provided, build a fast lookup table
--- @param palette? RGB[]
local function get_color_to_index(palette)
  if not palette then return end

  local color_to_index = {}
  local palette_size = #palette

  for i = 1, palette_size do
    local c = palette[i]
    local key = c[1] * 65536 + c[2] * 256 + c[3]
    color_to_index[key] = i - 1
  end

  return color_to_index
end

return get_color_to_index
