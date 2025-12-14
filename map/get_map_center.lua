local get_map_object = require('map/get_map_object')

local function get_map_center(map)
  local center_object_id = map.properties.map_center.id
  assert(center_object_id, "Map is missing required map_center object")
  return get_map_object(center_object_id, map)
end

return get_map_center
