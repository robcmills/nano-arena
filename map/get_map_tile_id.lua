local get_map_layer = require('map/get_map_layer')

local function get_map_tile_id(tile_x, tile_y, layer_name)
  local layer = get_map_layer(layer_name)
  assert(layer, 'layer ' .. layer_name .. ' not found')
  return layer.data[tile_y * layer.width + tile_x + 1]
end

return get_map_tile_id
