local g = require('g')

local function get_canvas_center()
  local w, h = g.canvas:getDimensions()
  return w / 2, h / 2
end

return get_canvas_center
