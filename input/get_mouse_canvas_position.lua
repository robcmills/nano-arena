local screen_to_canvas = require('util/screen_to_canvas')

local function get_mouse_canvas_position()
  local x, y = love.mouse.getPosition()
  return screen_to_canvas(x), screen_to_canvas(y)
end

return get_mouse_canvas_position
