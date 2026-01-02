-- JASC-PAL Palette Generator

-- Helper function: Convert HSL to RGB
-- h: 0-360, s: 0-1, l: 0-1
-- Returns r, g, b (0-255)
local function hslToRgb(h, s, l)
  h = h / 360
  local r, g, b

  if s == 0 then
    r, g, b = l, l, l
  else
    local function hueToRgb(p, q, t)
      if t < 0 then t = t + 1 end
      if t > 1 then t = t - 1 end
      if t < 1 / 6 then return p + (q - p) * 6 * t end
      if t < 1 / 2 then return q end
      if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
      return p
    end

    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q

    r = hueToRgb(p, q, h + 1 / 3)
    g = hueToRgb(p, q, h)
    b = hueToRgb(p, q, h - 1 / 3)
  end

  return math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5)
end


local hues_count = 12 -- Number of hue segments (divisible by 3 in order to include pure red, green, and blue)
local lights_count = 5 -- Number of lightness divisions (odd to include a "middle" 50% lightness, in order to include pure red, green, and blue)

local palette = {}

-- grayscale palette
local grays_count = lights_count * 2 - 1
for i = 0, grays_count do
  local lightness = i / grays_count
  local r, g, b = hslToRgb(0, 0, lightness)
  table.insert(palette, { r, g, b })
end

-- rainbow palette
for i = 0, hues_count - 1 do
  local hue = (i / hues_count) * 360

  -- lightness variations (maximum saturation)
  local saturation = 1.0
  for j = 1, lights_count do
    local lightness = j / (lights_count + 1) -- Avoid 0 (black) and 1 (white)
    local r, g, b = hslToRgb(hue, saturation, lightness)
    table.insert(palette, { r, g, b })
  end

  -- lightness variations (low saturation)
  saturation = 0.5
  for k = 1, lights_count do
    local lightness = k / (lights_count + 1) -- Avoid 0 (black) and 1 (white)
    local r, g, b = hslToRgb(hue, saturation, lightness)
    table.insert(palette, { r, g, b })
  end
end

-- Write to JASC-PAL file
local function writePalette(filename, pal)
  local file = io.open(filename, "w")
  if not file then
    error("Could not open file for writing: " .. filename)
  end

  -- JASC-PAL header
  file:write("JASC-PAL\n")
  file:write("0100\n")
  file:write(string.format("%d\n", #pal))

  -- Write each color
  for _, color in ipairs(pal) do
    file:write(string.format("%d %d %d\n", color[1], color[2], color[3]))
  end

  file:close()
  print(string.format("Palette written to '%s' with %d colors", filename, #pal))
end

-- Verify pure colors are present
local function verifyPureColors(pal)
  local hasRed, hasGreen, hasBlue = false, false, false

  for i, color in ipairs(pal) do
    if color[1] == 255 and color[2] == 0 and color[3] == 0 then
      hasRed = true
      print(string.format("Pure red found at index %d", i))
    end
    if color[1] == 0 and color[2] == 255 and color[3] == 0 then
      hasGreen = true
      print(string.format("Pure green found at index %d", i))
    end
    if color[1] == 0 and color[2] == 0 and color[3] == 255 then
      hasBlue = true
      print(string.format("Pure blue found at index %d", i))
    end
  end

  return hasRed and hasGreen and hasBlue
end

local total_colors = #palette
print(string.format("Total colors: %d", total_colors))
assert(total_colors <= 256, "Total colors exceed 256!")

if verifyPureColors(palette) then
  print("All pure RGB colors found!")
else
  print("WARNING: Not all pure RGB colors found in palette")
end

writePalette("assets/palette.pal", palette)
