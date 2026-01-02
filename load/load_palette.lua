local function load_palette(path)
  local palette = {}
  local file = io.open(path, 'r')

  if not file then
    error('Could not open palette file: ' .. path)
  end

  -- Read and validate header
  local header = file:read('*line')
  if header ~= 'JASC-PAL' then
    file:close()
    error('Invalid JASC-PAL file: missing header')
  end

  -- Read version (typically "0100")
  local version = file:read('*line')

  -- Read number of colors
  local num_colors = tonumber(file:read('*line'))

  -- Read each color
  for i = 1, num_colors do
    local line = file:read('*line')
    if line then
      local r, g, b = line:match('(%d+)%s+(%d+)%s+(%d+)')
      assert(r and g and b, 'Invalid color format')
      table.insert(palette, {
        tonumber(r),
        tonumber(g),
        tonumber(b)
      })
    end
  end

  file:close()
  return palette
end

return load_palette
