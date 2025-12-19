local g = require('g')

local function draw_canvas()
  local window_width, window_height = love.graphics.getDimensions()
  local canvas_width, canvas_height = g.canvas:getDimensions()

  -- Center the canvas
  local offset_x = (window_width - canvas_width * g.canvas_scale) / 2
  local offset_y = (window_height - canvas_height * g.canvas_scale) / 2

  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(g.canvas, offset_x, offset_y, 0, g.canvas_scale, g.canvas_scale)
end

return draw_canvas
