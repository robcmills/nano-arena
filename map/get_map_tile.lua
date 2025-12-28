local g = require('g')
local get_map_layer = require('map/get_map_layer')

local function get_map_tile(tile_x, tile_y, layer_name)
  local layer = get_map_layer(layer_name)
  assert(layer, 'layer ' .. layer_name .. ' not found')
  local tile_id = layer.data[tile_y * layer.width + tile_x + 1]
  if tile_id == 0 then
    return nil
  end
  local tileset = g.map.tilesets[1]
  for _, tile in ipairs(tileset.tiles) do
    if tile.id == tile_id then
      return tile
    end
  end
end

return get_map_tile
