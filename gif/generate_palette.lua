-- 6x6x6 RGB color cube (216 colors) plus 40 grayscale values
local function generate_palette()
  local palette = {}

  for i = 0, 215 do
    local r = math.floor(i / 36)
    local g = math.floor((i % 36) / 6)
    local b = i % 6
    palette[i] = {
      math.floor(r * 255 / 5),
      math.floor(g * 255 / 5),
      math.floor(b * 255 / 5)
    }
  end

  -- Add grayscale ramp
  for i = 216, 255 do
    local gray = math.floor((i - 216) * 255 / 39)
    palette[i] = { gray, gray, gray }
  end

  return palette
end

return generate_palette
