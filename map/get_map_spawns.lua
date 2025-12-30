local get_map_layer = require('map/get_map_layer')

local function get_map_spawns()
  local spawns_layer = get_map_layer('spawns')
  local spawns = {}
  for y = 0, spawns_layer.height - 1 do
    for x = 0, spawns_layer.width - 1 do
      local index = y * spawns_layer.width + x + 1
      if spawns_layer.data[index] ~= 0 then
        table.insert(spawns, { x = x, y = y })
      end
    end
  end
  return spawns
end

return get_map_spawns
