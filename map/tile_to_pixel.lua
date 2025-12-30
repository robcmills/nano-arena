local settings = require('settings')

local function tile_to_pixel(tile)
  return tile * settings.tile_size
end

return tile_to_pixel
