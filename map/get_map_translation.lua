local get_canvas_center = require('util/get_canvas_center')

-- get translation to render map such that the given map position is centered on the screen
local function get_map_translation(map_pos)
  local canvas_center_x, canvas_center_y = get_canvas_center()
  return canvas_center_x - map_pos.x, canvas_center_y - map_pos.y
end

return get_map_translation
