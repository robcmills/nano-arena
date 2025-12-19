local settings = require('settings')

-- converts tile coordinates to screen pixel coordinates
local function tile_to_pixel(tile_x, tile_y)
  local pixel_x = tile_x * settings.tile_size
  local pixel_y = tile_y * settings.tile_size
  return pixel_x, pixel_y
end

return tile_to_pixel
