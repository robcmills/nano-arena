local get_map_tile = require('map/get_map_tile')

local function is_wall(tile_x, tile_y)
  return get_map_tile(tile_x, tile_y, 'walls') ~= nil
end

return is_wall
