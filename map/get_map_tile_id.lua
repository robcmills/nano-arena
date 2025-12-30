local get_map_layer_by_name = require('map/get_map_layer_by_name')

local function get_map_tile_id(tile_x, tile_y, layer_name)
  local layer = get_map_layer_by_name(layer_name)
  assert(layer, 'layer ' .. layer_name .. ' not found')
  return layer.data[tile_y * layer.width + tile_x + 1]
end

return get_map_tile_id
