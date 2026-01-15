local g = require('g')

local function get_canvas_dimensions()
  return g.canvas:getDimensions()
end

return get_canvas_dimensions
