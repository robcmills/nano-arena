local get_map_layer_by_name = require('map/get_map_layer_by_name')
local settings = require('settings')

local function get_map_spawns()
  local objects_layer = get_map_layer_by_name('objects')
  local spawns = {}
  for _, object in ipairs(objects_layer.objects) do
    if object.properties.is_spawn then
      table.insert(spawns, {
        direction = object.properties.direction,
        x = object.x / settings.tile_size,
        y = object.y / settings.tile_size
      })
    end
  end
  return spawns
end

return get_map_spawns
