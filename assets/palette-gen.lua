-- Palette Generator - JASC-PAL Format
-- Generates a rainbow palette with grayscale appended

-- Adjustable parameters
local HUE_SEGMENTS = 16   -- Number of hue divisions
local LIGHTNESS_STEPS = 8 -- Number of lightness divisions per hue

-- HSL to RGB conversion
local function hsl_to_rgb(h, s, l)
  -- h: 0-360, s: 0-1, l: 0-1
  -- returns r, g, b as 0-255 integers

  if s == 0 then
    -- Grayscale
    local gray = math.floor(l * 255 + 0.5)
    return gray, gray, gray
  end

  local function hue_to_rgb(p, q, t)
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < 1 / 6 then return p + (q - p) * 6 * t end
    if t < 1 / 2 then return q end
    if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
    return p
  end

  local q = l < 0.5 and l * (1 + s) or l + s - l * s
  local p = 2 * l - q
  local h_normalized = h / 360

  local r = hue_to_rgb(p, q, h_normalized + 1 / 3)
  local g = hue_to_rgb(p, q, h_normalized)
  local b = hue_to_rgb(p, q, h_normalized - 1 / 3)

  return math.floor(r * 255 + 0.5),
      math.floor(g * 255 + 0.5),
      math.floor(b * 255 + 0.5)
end

-- Generate the palette
local function generate_palette(hue_segments, lightness_steps)
  local palette = {}

  -- Generate rainbow palette (max saturation)
  for hue_index = 0, hue_segments - 1 do
    local hue = (hue_index / hue_segments) * 360

    for light_index = 1, lightness_steps do
      -- Lightness from dark to light, avoiding 0 and 1 extremes
      -- Range: roughly 0.1 to 0.9 for visible colors
      local lightness = light_index / (lightness_steps + 1)

      local r, g, b = hsl_to_rgb(hue, 1.0, lightness)       -- saturation = 1.0
      table.insert(palette, { r = r, g = g, b = b })
    end
  end

  -- Generate grayscale palette (zero saturation)
  local grayscale_steps = lightness_steps * 2
  for gray_index = 0, grayscale_steps - 1 do
    -- Full range from black to white
    local lightness = gray_index / (grayscale_steps - 1)
    print('lightness: ' .. lightness)

    local r, g, b = hsl_to_rgb(0, 0, lightness)     -- saturation = 0
    print('r: ' .. r .. ' g: ' .. g .. ' b: ' .. b)
    table.insert(palette, { r = r, g = g, b = b })
  end

  return palette
end

-- Write palette to JASC-PAL format file
local function write_jasc_pal(filename, palette)
  local file, err = io.open(filename, "w")
  if not file then
    print("Error opening file: " .. err)
    return false
  end

  -- JASC-PAL header
  file:write("JASC-PAL\n")
  file:write("0100\n")
  file:write(tostring(#palette) .. "\n")

  -- Write each color
  for _, color in ipairs(palette) do
    file:write(string.format("%d %d %d\n", color.r, color.g, color.b))
  end

  file:close()
  print(string.format("Palette written to '%s' with %d colors", filename, #palette))
  return true
end

-- Print palette info
local function print_palette_info(hue_segments, lightness_steps)
  local rainbow_colors = hue_segments * lightness_steps
  local grayscale_colors = lightness_steps * 2
  local total_colors = rainbow_colors + grayscale_colors

  print("=== Palette Configuration ===")
  print(string.format("Hue segments:      %d", hue_segments))
  print(string.format("Lightness steps:   %d", lightness_steps))
  print(string.format("Rainbow colors:    %d", rainbow_colors))
  print(string.format("Grayscale colors:  %d", grayscale_colors))
  print(string.format("Total colors:      %d", total_colors))
  print("=============================")
end

-- Main execution
local function main()
  print_palette_info(HUE_SEGMENTS, LIGHTNESS_STEPS)

  local palette = generate_palette(HUE_SEGMENTS, LIGHTNESS_STEPS)
  write_jasc_pal("assets/palette.pal", palette)
end

main()
