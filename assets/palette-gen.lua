-- JASC-PAL Palette Generator
-- Generates a rainbow palette with lightness variations, and a grayscale

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


local n = 15 -- Number of hue segments (divisible by 3 in order to include pure red, green, and blue)
local m = 9 -- Number of lightness divisions (odd to include a "middle" 50% lightness, in order to include pure red, green, and blue)

-- Calculate total colors
local rainbow_colors = n * (m + m / 2)
local grayscale_colors = m * 2
local total_colors = rainbow_colors + grayscale_colors

print(string.format("Configuration: n=%d hues, m=%d lightness steps", n, m))
print(string.format("Rainbow colors: %d", rainbow_colors))
print(string.format("Grayscale colors: %d", grayscale_colors))
print(string.format("Total colors: %d", total_colors))

assert(total_colors <= 256, "Total colors exceed 256!")

-- Generate the palette
local palette = {}

-- Generate rainbow palette
for i = 0, n - 1 do
  local hue = (i / n) * 360   -- Divide hue spectrum evenly

  -- Add lightness variations (maximum saturation = 1.0)
  for j = 1, m do
    local lightness = j / (m + 1)     -- Avoid 0 (black) and 1 (white)
    local r, g, b = hslToRgb(hue, 1.0, lightness)
    table.insert(palette, { r, g, b })
  end
end

-- Generate grayscale palette
for i = 0, m - 1 do
  local lightness = i / (m - 1)   -- 0 to 1 inclusive (black to white)
  local r, g, b = hslToRgb(0, 0, lightness)     -- Hue doesn't matter when saturation is 0
  table.insert(palette, { r, g, b })
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

-- Verify and write
print("\nVerifying pure colors...")
if verifyPureColors(palette) then
  print("All pure RGB colors found!")
else
  print("WARNING: Not all pure RGB colors found in palette")
end

-- Write the palette file
writePalette("assets/palette.pal", palette)
