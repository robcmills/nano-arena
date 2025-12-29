local get_map_tile_id = require('map/get_map_tile_id')

local function is_void(tile_x, tile_y)
  return get_map_tile_id(tile_x, tile_y, 'grid') == 0
end

return is_void
