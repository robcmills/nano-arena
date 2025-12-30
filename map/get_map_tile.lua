local g = require('g')
local get_map_tile_id = require('map/get_map_tile_id')

local function get_map_tile(tile_x, tile_y, layer_name)
  local tile_id = get_map_tile_id(tile_x, tile_y, layer_name)
  if not tile_id then
    return nil
  end
  local tileset = g.map.tilesets[1]
  for _, tile in ipairs(tileset.tiles) do
    if tile.id + 1 == tile_id then
      return tile
    end
  end
end

return get_map_tile
